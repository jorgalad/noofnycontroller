import Live
import time
from Logger import Logger

 
class NoofnyController:
    __module__ = __name__
    __doc__ = 'NoofnyController\n'

    # Defines logging consts. Set these to 1 to enable or 2 to disable to related logging events.
    _LOG_CONNECT_EVENTS         = 1
    _LOG_DISCONNECT_EVENTS      = 1
    _LOG_UPDATE_DISPLAY         = 0
    _LOG_REFRESH_STATE          = 0
    _LOG_BUILD_MIDI_MAP         = 0
    _LOG_MIDI_IN_EVENTS         = 0
    _LOG_MIDI_OUT_EVENTS        = 0
    _LOG_TEMPO_EVENTS           = 0
    _LOG_LISTENER_EVENTS        = 0
    _LOG_HANDLER_EVENTS         = 0
    _LOG_DISPLAY_EVENTS         = 0

    # Defines environment consts.
    _MAX_SONGS                          = 8
    _CURRENT_SONG                       = 0
    _SCENES_PER_SONG                    = 8
    _MASTER_CHANNEL                     = 8
    _LAST_BEAT                          = 0
    _LAST_BAR                           = 0
    _CHANGE_TEMPO_ON_SONG_CHANGE        = 0
    _MAX_NUMBER_OF_GROUP_TRACK_CLIPS    = 32 # theres currently only 4 clips but 32 should be enough for future expansion.

    # Defines MIDI consts. 
    _SYSEX_BEGIN                = (240,)
    _SYSEX_END                  = (247,)
    _SYSEX_MESSAGE_CONNECT      = (0xF0,0x00,0x01,0x77,0xF7)
    _SYSEX_MESSAGE_DISCONNECT   = (0xF0,0x00,0x02,0x77,0xF7)
    _NOTE_ON_EVENT              = 144
    _NOTE_OFF_EVENT             = 128
    _CC_EVENT                   = 176
    _NOTE_SEND_OFFSET           = 0x20
    _CC_VOLUME                  = 7
    _CC_FX_SEND_A               = 28
    _CC_FX_SEND_B               = 29
    _CC_FX_SEND_C               = 30
    _CC_FX_SEND_D               = 31
    _CC_CHANNEL_EQ_LO           = 50
    _CC_CHANNEL_EQ_HI           = 51
    _CC_CHANNEL_EQ_DIRTY        = 52
    _CC_CHANNEL_CHOP_TYPE       = 53
    _CC_CHANNEL_CHOP_RATE       = 54
    _CC_CHANNEL_CHOP_AMMOUNT    = 55
    _CC_CHANNEL_Y               = 56
    _CC_CHANNEL_X               = 57


    # Defines hardware consts.
    _BUTTON_DOWN                = 1
    _BUTTON_UP                  = 0
    _LED_OFF                    = 0x00
    _LED_RED                    = 0x10
    _LED_GREEN                  = 0x20
    _LED_BLUE                   = 0x40
    _LED_CYAN                   = 0x60
    _LED_MAGENTA                = 0x50
    _LED_YELLOW                 = 0x30
    _LED_WHITE                  = 0x70
    _CLIP_STATUS_ARMED          = 4
    _CLIP_STATUS_TRIGGERED      = 3
    _CLIP_STATUS_PLAYING        = 2
    _CLIP_STATUS_PRESENT        = 1
    _CLIP_STATUS_NONE           = 0
    _IGNORE_DISPLAY_CLIPS       = 0
    _IGNORE_DISPLAY_CHANNELS    = 0
    _IGNORE_DISPLAY_MUTES       = 0
    _IGNORE_DISPLAY_SYSTEM      = 0

    # Define global vars.
    _LAST_TRIGGERED_CLIPS       = [0,0,0,0,0,0,0,0]
    _EQ_STATES                  = [0,0,0,0,0,0,0,0]
    _FX_STATES                  = [0,0,0,0,0,0,0,0]
    _MASTER_FX_STATE            = 0
    _CLIP_COUNT_FX_A            = 0
    _CLIP_COUNT_FX_B            = 0
    _CLIP_COUNT_FX_C            = 0
    _CLIP_COUNT_FX_D            = 0
    _BUILD_MIDIMAP_COUNT        = 0
    _DISCONNECTED               = 0

    _CLIP_LENGTHS = [[0,0]]




    # Called once each time the class is instantiated from Live.
    def __init__(self, appInstance):
        self._DISCONNECTED = 0;
        self.logger = Logger()
        if (self._LOG_CONNECT_EVENTS):
            self.logger.log("************ NoofnyController | CONNECTING ************")
        self._appInstance = appInstance
        self._appInstance.show_message("************ NoofnyController | CONNECTING ************")
        self.AddListeners()
        if (self._LOG_CONNECT_EVENTS):
            self.logger.log(">>> NoofnyController > INIT OK")
        self.GetEffectChannelClipCounts()
        self._appInstance.show_message("NoofnyController > INIT OK")



    # Called when the class instance is disposed by Live.
    def disconnect(self):
        if (self._LOG_DISCONNECT_EVENTS):
            self.logger.log("************ NoofnyController | DISCONNECTED ************")
        self.RemoveListeners()
        self.send_midi(self._SYSEX_MESSAGE_DISCONNECT)
        self._DISCONNECTED = 1;

        

         
         
         
         
         
         
         
         
    # Here we tell Live which methods we want to execute when certain SONG/VIEW/TRACK events are fired.
    def AddListeners(self):
        try:
            if (self._LOG_LISTENER_EVENTS):
                self.logger.log("Adding Master Level & Clip Listeners...")
            # create the output level listener for the master track.
            masterTrack = self.song().tracks[len(self.song().tracks)-1]
            masterLevelListener = self.CreateMasterLevelListener()
            if not (masterTrack.output_meter_level_has_listener(masterLevelListener)):
                masterTrack.add_output_meter_level_listener(masterLevelListener)
            # create the clip listeners for the master track.
            self.AddMasterClipListeners(masterTrack)
        except:
            self.logger.log("    ERROR >>> Adding Master Level & Clip Listeners")

        # create the listeners just for the 8 group tracks.
        for channelIndex in range(0, 8):
            try:
                groupTrack = self.GetGroupTrack(channelIndex)
                if (groupTrack == None):
                    continue    
                self.AddGroupClipListeners(groupTrack, channelIndex)
            except:
                self.logger.log("    ERROR >>> Adding Track Listeners channel=" + str(channel))
        
        # now create the clip listeners - only for clip tracks.
        for track in self.song().tracks:
            try:
                if (track.has_audio_output != 1):
                    continue    # so we skip midi tracks.
                trackChannel = self.GetTrackChannel(track)
                if (trackChannel == None):
                    continue    # so we skip non clip tracks.
                self.AddClipListeners(track, trackChannel)
            except:
                self.logger.log("    ERROR >>> Adding Track Listeners track=" + str(track.name))
                



    # Here we tell Live which methods we want to execute when certain CLIP events are fired.
    def AddClipListeners(self, track, channelIndex):
        if (self._LOG_LISTENER_EVENTS):
            self.logger.log("AddClipListeners track=" + str(track.name))
        try:
            for clipSlotIndex in range(0, 128):
                clipIndex = clipSlotIndex % self._SCENES_PER_SONG
                clipSlot = track.clip_slots[clipSlotIndex]
                if (clipSlot == None):
                    continue
                if not (clipSlot.has_clip):
                    continue
                clip = clipSlot.clip
                clipTriggeredListener = self.CreateClipTriggeredListener(clip, clipSlotIndex, clipIndex, track, channelIndex)
                if not (clipSlot.is_triggered_has_listener(clipTriggeredListener)):
                    clipSlot.add_is_triggered_listener(clipTriggeredListener)
                clipPlayingListener = self.CreateClipPlayingListener(clip, clipSlotIndex, clipIndex, track, channelIndex)
                if not (clip.playing_status_has_listener(clipPlayingListener )):
                    clip.add_playing_status_listener(clipPlayingListener)
        except:
            self.logger.log("    ERROR >>> AddClipListeners track=" + str(track.name))


    # Here we tell Live which methods we want to execute when certain CLIP events are fired.
    def AddGroupClipListeners(self, track, channelIndex):
        if (self._LOG_LISTENER_EVENTS):
            self.logger.log("AddGroupClipListeners track=" + str(track.name))
        try:
            for clipSlotIndex in range(0, self._MAX_NUMBER_OF_GROUP_TRACK_CLIPS):  
                clipSlot = track.clip_slots[clipSlotIndex]
                if (clipSlot == None):
                    continue
                if not (clipSlot.has_clip):
                    continue
                clipPlayingListener = self.CreateGroupClipPlayingListener(clipSlot.clip, clipSlotIndex, track, channelIndex)
                if not (clipSlot.clip.playing_status_has_listener(clipPlayingListener)):
                    clipSlot.clip.add_playing_status_listener(clipPlayingListener)
        except:
            self.logger.log("    ERROR >>> AddGroupClipListeners track=" + str(track.name))

    # Here we tell Live which methods we want to execute when certain CLIP events are fired.
    def AddMasterClipListeners(self, track):
        if (self._LOG_LISTENER_EVENTS):
            self.logger.log("AddMasterClipListeners track=" + str(track.name))
        try:
            for clipSlotIndex in range(0, self._MAX_NUMBER_OF_GROUP_TRACK_CLIPS):  
                clipSlot = track.clip_slots[clipSlotIndex]
                if (clipSlot == None):
                    continue
                if not (clipSlot.has_clip):
                    continue
                clipPlayingListener = self.CreateMasterClipPlayingListener(clipSlot.clip, clipSlotIndex, track)
                if not (clipSlot.clip.playing_status_has_listener(clipPlayingListener)):
                    clipSlot.clip.add_playing_status_listener(clipPlayingListener)
        except:
            self.logger.log("    ERROR >>> AddMasterClipListeners track=" + str(track.name))

        

   # Here we tell Live which methods we want to execute when certain SONG/VIEW/TRACK events are fired.
    def RemoveListeners(self):
        try:
            if (self._LOG_LISTENER_EVENTS):
                self.logger.log("Removing Master Level & Clip Listeners...")
            # create the output level listener for the master track.
            masterTrack = self.song().tracks[len(self.song().tracks)-1]
            masterLevelListener = self.CreateMasterLevelListener()
            if (masterTrack.output_meter_level_has_listener(masterLevelListener)):
                masterTrack.remove_output_meter_level_listener(masterLevelListener)
            # create the clip listeners for the master track.
            self.RemoveMasterClipListeners(masterTrack)
        except:
            self.logger.log("    ERROR >>> Removing Master Level & Clip Listeners")

        # create the listeners just for the 8 group tracks.
        for channelIndex in range(0, 8):
            try:
                groupTrack = self.GetGroupTrack(channelIndex)
                if (groupTrack == None):
                    continue    
                self.RemoveGroupClipListeners(groupTrack, channelIndex)
            except:
                self.logger.log("    ERROR >>> Removing Track Listeners channel=" + str(channel))
        
        # now create the clip listeners - only for clip tracks.
        for track in self.song().tracks:
            try:
                if (track.has_audio_output != 1):
                    continue    # so we skip midi tracks.
                trackChannel = self.GetTrackChannel(track)
                if (trackChannel == None):
                    continue    # so we skip non clip tracks.
                self.RemoveClipListeners(track, trackChannel)
            except:
                self.logger.log("    ERROR >>> Removing Track Listeners track=" + str(track.name))


 
 

    # Here we tell Live which methods we want to execute when certain CLIP events are fired.
    def RemoveClipListeners(self, track, channelIndex):
        if (self._LOG_LISTENER_EVENTS):
            self.logger.log("RemoveClipListeners track=" + str(track.name))
        try:
            for clipSlotIndex in range(0, 128):
                clipIndex = clipSlotIndex % self._SCENES_PER_SONG
                clipSlot = track.clip_slots[clipSlotIndex]
                if (clipSlot == None):
                    continue
                if not (clipSlot.has_clip):
                    continue
                clip = clipSlot.clip
                clipTriggeredListener = self.CreateClipTriggeredListener(clip, clipSlotIndex, clipIndex, track, channelIndex)
                if (clipSlot.is_triggered_has_listener(clipTriggeredListener)):
                    clipSlot.remove_is_triggered_listener(clipTriggeredListener)
                clipPlayingListener = self.CreateClipPlayingListener(clip, clipSlotIndex, clipIndex, track, channelIndex)
                if (clip.playing_status_has_listener(clipPlayingListener )):
                    clip.remove_playing_status_listener(clipPlayingListener)
        except:
            self.logger.log("    ERROR >>> RemoveClipListeners track=" + str(track.name))


    # Here we tell Live which methods we want to execute when certain CLIP events are fired.
    def RemoveGroupClipListeners(self, track, channelIndex):
        if (self._LOG_LISTENER_EVENTS):
            self.logger.log("RemoveGroupClipListeners track=" + str(track.name))
        try:
            for clipSlotIndex in range(0, self._MAX_NUMBER_OF_GROUP_TRACK_CLIPS):  
                clipSlot = track.clip_slots[clipSlotIndex]
                if (clipSlot == None):
                    continue
                if not (clipSlot.has_clip):
                    continue
                clipPlayingListener = self.CreateGroupClipPlayingListener(clipSlot.clip, clipSlotIndex, track, channelIndex)
                if (clipSlot.clip.playing_status_has_listener(clipPlayingListener)):
                    clipSlot.clip.remove_playing_status_listener(clipPlayingListener)
        except:
            self.logger.log("    ERROR >>> RemoveGroupClipListeners track=" + str(track.name))

    # Here we tell Live which methods we want to execute when certain CLIP events are fired.
    def RemoveMasterClipListeners(self, track):
        if (self._LOG_LISTENER_EVENTS):
            self.logger.log("RemoveMasterClipListeners track=" + str(track.name))
        try:
            for clipSlotIndex in range(0, self._MAX_NUMBER_OF_GROUP_TRACK_CLIPS):  
                clipSlot = track.clip_slots[clipSlotIndex]
                if (clipSlot == None):
                    continue
                if not (clipSlot.has_clip):
                    continue
                clipPlayingListener = self.CreateMasterClipPlayingListener(clipSlot.clip, clipSlotIndex, track)
                if (clipSlot.clip.playing_status_has_listener(clipPlayingListener)):
                    clipSlot.clip.remove_playing_status_listener(clipPlayingListener)
        except:
            self.logger.log("    ERROR >>> RemoveMasterClipListeners track=" + str(track.name))















        


    def CreateMasterLevelListener(self):
        def MasterLevelChanged():
            track = self.song().master_track
            if (self._LOG_LISTENER_EVENTS):
                self.logger.log("----------------MasterLevelChanged : track=" + str(track.name))
            if (track.output_meter_level > 0.90):
                self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 17, self._LED_RED))
            elif (track.output_meter_level >= 0.85 and track.output_meter_level <= 0.90):
                self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 17, self._LED_YELLOW))
            try:
                beatTime = self.song().get_current_beats_song_time()
                if (beatTime.beats != self._LAST_BEAT):
                    if (track.output_meter_level < 0.85):
                        self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 17, self._LED_OFF))
                self._LAST_BEAT = beatTime.beats
            except:
                self.logger.log("    ERROR >>> MasterLevelChanged : track=" + str(track.name))
        return MasterLevelChanged;


 
    
    def CreateClipTriggeredListener(self, clip, clipSlotIndex, clipIndex, track, channelIndex):
        def ClipTriggered():
            if (self._LOG_LISTENER_EVENTS):
                self.logger.log("ClipTriggered > track=" + str(track.name) + " channelIndex=" + str(channelIndex) + " clip=" + str(clip.name) + " clipIndex=" + str(clipIndex) + " is_triggered=" + str(clip.is_triggered))
            try:
                clipVisible = (clipSlotIndex / self._SCENES_PER_SONG)
                if (clipVisible != self._CURRENT_SONG):
                    return None
                # because the is_triggered property is always 0, we just force it to display triggered.
                self.send_midi((self._NOTE_ON_EVENT + channelIndex, clipIndex + 3 + self._NOTE_SEND_OFFSET, self._LED_YELLOW))
            except:
                self.logger.log("    ERROR >>> ClipTriggered > track=" + str(track.name) + " channelIndex=" + str(channelIndex) + " clip=" + str(clip.name) + " clipIndex=" + str(clipIndex) + " is_triggered=" + str(clip.is_triggered))
                return None
        return ClipTriggered;


    def CreateClipPlayingListener(self, clip, clipSlotIndex, clipIndex, track, channelIndex):
        def ClipPlayingChanged():
            if (self._LOG_LISTENER_EVENTS):
                self.logger.log("ClipPlayingChanged > track=" + str(track.name) + " channelIndex=" + str(channelIndex) + " clip=" + str(clip.name) + " clipIndex=" + str(clipIndex))
            try:
                clipVisible = (clipSlotIndex / self._SCENES_PER_SONG)
                if (clipVisible != self._CURRENT_SONG):
                    return None
                if (clip.is_playing):
                    if (track.arm):
                        self.send_midi((self._NOTE_ON_EVENT + channelIndex, clipIndex + 3 + self._NOTE_SEND_OFFSET, self._LED_RED))
                    else:
                        self.send_midi((self._NOTE_ON_EVENT + channelIndex, clipIndex + 3 + self._NOTE_SEND_OFFSET, self._LED_GREEN))
                    self._LAST_TRIGGERED_CLIPS[channelIndex] = 0
                elif (track.clip_slots[clipSlotIndex].is_triggered):
                    self.send_midi((self._NOTE_ON_EVENT + channelIndex, clipIndex + 3 + self._NOTE_SEND_OFFSET, self._LED_YELLOW))
                else:
                    self.send_midi((self._NOTE_ON_EVENT + channelIndex, clipIndex + 3 + self._NOTE_SEND_OFFSET, self._LED_BLUE))
            except:
                self.logger.log("    ERROR >>> ClipPlayingChanged > track=" + str(track.name) + " channelIndex=" + str(channelIndex) + " clip=" + str(clip.name) + " clipIndex=" + str(clipIndex))
                return None
        return ClipPlayingChanged;


    def CreateGroupClipPlayingListener(self, clip, clipIndex, track, channelIndex):
        def GroupClipPlayingChanged():
            if (self._LOG_LISTENER_EVENTS):
                self.logger.log("GroupClipPlayingChanged > track=" + str(track.name) + " channelIndex=" + str(channelIndex) + " clip=" + str(clip.name) + " clipIndex=" + str(clipIndex))
            try:
                self.DisplayChannelButtonsForChannel(channelIndex)
            except:
                self.logger.log("    ERROR >>> GroupClipPlayingChanged > track=" + str(track.name) + " channelIndex=" + str(channelIndex) + " clip=" + str(clip.name) + " clipIndex=" + str(clipIndex))
                return None
        return GroupClipPlayingChanged;

            
    def CreateMasterClipPlayingListener(self, clip, clipIndex, track):
        def MasterClipPlayingChanged():
            if (self._LOG_LISTENER_EVENTS):
                self.logger.log("MasterClipPlayingChanged > track=" + str(track.name) + " clip=" + str(clip.name) + " clipIndex=" + str(clipIndex))
            try:
                if (clipIndex == 0):
                    if( clip.is_triggered):
                        None
#                        self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 25, self._LED_YELLOW))
#                        self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 26, self._LED_YELLOW))
                    elif (clip.is_playing):
                        self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 25, self._LED_OFF))
                        self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 26, self._LED_OFF))
                elif (clipIndex == 1):
                    if( clip.is_triggered):
                        #self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 25, self._LED_YELLOW))
                        self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 26, self._LED_OFF))
                    elif (clip.is_playing):
                        self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 25, self._LED_MAGENTA))
                        self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 26, self._LED_OFF))
                elif (clipIndex == 2):
                    if( clip.is_triggered):
                        self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 25, self._LED_OFF))
                        #self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 26, self._LED_YELLOW))
                    elif (clip.is_playing):
                        self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 25, self._LED_OFF))
                        self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 26, self._LED_MAGENTA))
                elif (clipIndex == 3):
                    if( clip.is_triggered):
                        None
                        #self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 25, self._LED_YELLOW))
                        #self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 26, self._LED_YELLOW))
                    elif (clip.is_playing):
                        self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 25, self._LED_MAGENTA))
                        self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 26, self._LED_MAGENTA))
#                if (self._MASTER_FX_STATE == 0):     # 0 | 0
#                    self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 25, self._LED_OFF))
#                    self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 26, self._LED_OFF))
#                elif (self._MASTER_FX_STATE == 1):  # 1 | 0
#                    self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 25, self._LED_MAGENTA))
#                    self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 26, self._LED_OFF))
#                elif (self._MASTER_FX_STATE == 2):  # 0 | 1
#                    self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 25, self._LED_OFF))
#                    self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 26, self._LED_MAGENTA))
#                elif (self._MASTER_FX_STATE == 3):  # 1 | 1
#                    self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 25, self._LED_MAGENTA))
#                    self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 26, self._LED_MAGENTA))
            except:
                self.logger.log("    ERROR >>> MasterClipPlayingChanged > track=" + str(track.name) + " clip=" + str(clip.name) + " clipIndex=" + str(clipIndex))
                return None
        return MasterClipPlayingChanged;
















    # Not sure about this one yet - some LiveAPI thing.
    def connect_script_instances(self, scripts):
        pass

    # Not sure about this one yet - some LiveAPI thing.
    def script_handle(self):
        return self._appInstance.handle()
            
    # Not sure about this one yet - some LiveAPI thing.
    def instance_identifier(self):
        return self._appInstance.instance_identifier()

    # Util - returns reference to the application object from the Live instance.
    def application(self):
        return Live.Application.get_application()
        
    # Util - returns reference to the song object from the Live instance.
    def song(self):
        return self._appInstance.song()

    # Not sure about this one yet - some LiveAPI thing.
    def suggest_input_port(self):
        return ''
        
    # Not sure about this one yet - some LiveAPI thing.
    def suggest_output_port(self):
        return ''
        
    # Not sure about this one yet - some LiveAPI thing.
    def can_lock_to_devices(self):
        return True
        
    # Not sure about this one yet - some LiveAPI thing.
    def suggest_map_mode(self, cc_no):
        return Live.MidiMap.MapMode.absolute
        
    # Gets called when Live decides it's time to refresh. Enable to log to see when.
    def update_display(self):
        if (self._LOG_UPDATE_DISPLAY):
            self.logger.log(">>> update_display")

    # Gets called from time to time - enable the log to see when.
    def refresh_state(self):
        if (self._LOG_REFRESH_STATE):
            self.logger.log(">>> refresh_state")
    
    # Util to convert an unsigned int to a tuple containing two 7-bit bytes. Max int value is 14 bits i.e. 16384.
    def IntToMidi(int):
        msb = (int >> 7) & 0x7F
        lsb = int & 0x7F
        return (msb,lsb)


    # LiveAPI event.
    # Called each time Live decides it's time to re-map all the internal MIDI stuff.
    # Example - when you add or remove tracks, devices, or change your set around, etc.
    def build_midi_map(self, midi_map_handle):
        if (self._LOG_BUILD_MIDI_MAP):
            self.logger.log(">>> build_midi_map")
        try:
                    
            self._appInstance.show_message(">>> build_midi_map # " + str(self._BUILD_MIDIMAP_COUNT))
            self.GatherClipLengths()
            map_mode = Live.MidiMap.MapMode.absolute
            for channel in range(0,16):
                for cc in range(127):
                    Live.MidiMap.forward_midi_cc(self.script_handle(),midi_map_handle,channel,cc)
                    Live.MidiMap.forward_midi_note(self.script_handle(),midi_map_handle,channel,cc)
            self._BUILD_MIDIMAP_COUNT += 1
            if (self._BUILD_MIDIMAP_COUNT >= 4):                # seems its pointless doing this the first 4 times (no MIDI-out it seems)
                if (self._BUILD_MIDIMAP_COUNT == 4):
                    self.send_midi(self._SYSEX_MESSAGE_CONNECT) # only need to send welcome once per session
                    time.sleep(1)
                    self.SetCurrentSong(0)
                else:
                    self.GatherSongState()
                    self.SetCurrentSong(self._CURRENT_SONG)
                    self.DisplayChannelButtons()
                    self.ResetEffectClips()
                    self.ResetMasterClips()
        except:
            self.logger.log("    ERROR >>> build_midi_map midi_map_handle=" + str(midi_map_handle) + " # " + str(self._BUILD_MIDIMAP_COUNT))
        
        
            


    # LiveAPI event.
    # Util that wraps the given MIDI message and sends it as SYSEX.
    # Data must be a tuple of bytes, remember only 7-bit data is allowed for SYSEX.
    def sendSysex(self, midi_event_bytes):
        if (self._LOG_MIDI_OUT_EVENTS):
            self.logger.log("sendSysex > " + str(midi_event_bytes))
        self.send_midi(_SYSEX_BEGIN + midi_event_bytes + _SYSEX_END)
        
    # LiveAPI event.
    # Used to send the given MIDI message to the assigned MIDI out port in the remote control settings.
    def send_midi(self, midi_event_bytes):
        if (self._DISCONNECTED):
            return
        if (self._LOG_MIDI_OUT_EVENTS):
            self.logger.log("send_midi > " + str(midi_event_bytes))
        try:
            self._appInstance.send_midi(midi_event_bytes)
        except:
            self.logger.log("    ERROR >>> send_midi midi_event_bytes=" + str(midi_event_bytes))
        
    # LiveAPI event.
    # Here we interupt the flow of incoming MIDI to Live via the assigned MIDI in port in remote control settings.
    # Mostly here I assign the incoming MIDI message to various methods below depending if it's NOTE or CC.
    def receive_midi(self, midi_bytes):
        if (self._LOG_MIDI_IN_EVENTS):
            self.logger.log("receive_midi > " + str(midi_bytes))
        try:
            eventType = midi_bytes[0] & 240
            channelIndex = midi_bytes[0] & 15
            if (eventType == self._CC_EVENT):
                controllerIndex = midi_bytes[1]
                potValue = midi_bytes[2]
                self.HandlePot(channelIndex, controllerIndex, potValue)
            elif((eventType == self._NOTE_ON_EVENT) or (eventType == self._NOTE_OFF_EVENT)):
                buttonIndex = midi_bytes[1]
                buttonState = midi_bytes[2]
                if (channelIndex == self._MASTER_CHANNEL):
                    self.HandleSystemButton(buttonIndex, buttonState)
                else:
                    if (buttonIndex >= 3 and buttonIndex <= 10):
                        self.HandleClipButton(channelIndex, buttonIndex, buttonState)
                    else:
                        self.HandleChannelButton(channelIndex, buttonIndex, buttonState)
        except:
            self.logger.log("    ERROR >>> receive_midi midi_bytes=" + str(midi_bytes))

















    # This handles all pots - both channel strip and master section.
    def HandlePot(self, channelIndex, controllerIndex, potValue):
        if (self._LOG_HANDLER_EVENTS):
            self.logger.log("HandlePot > channelIndex=" + str(channelIndex) + " controllerIndex=" + str(controllerIndex)  + " potValue=" + str(potValue))
        try:
            if (channelIndex >= 0 and channelIndex < 8):
                self._appInstance.show_message("HandlePot CHANNEL > channelIndex=" + str(channelIndex) + " controllerIndex=" + str(controllerIndex)  + " potValue=" + str(potValue))
                groupTrack = self.GetGroupTrack(channelIndex)
                if (groupTrack == None):
                    return

                # VOLUME
                if (controllerIndex == self._CC_VOLUME):
                    volume = (float(potValue) / float(127)) * float(1)
                    groupTrack.mixer_device.volume.value = volume
                
                # EQ - LO
                elif (controllerIndex == self._CC_CHANNEL_EQ_LO):
                    groupTrack.devices[0].parameters[3].value = potValue
                
                # EQ - HI
                elif (controllerIndex == self._CC_CHANNEL_EQ_HI):
                    groupTrack.devices[0].parameters[4].value = potValue
                
                # EQ - COLOR
                elif (controllerIndex == self._CC_CHANNEL_EQ_DIRTY):
                    groupTrack.devices[0].parameters[2].value = potValue

                # LFO - Z
                elif (controllerIndex == self._CC_CHANNEL_CHOP_TYPE):
                    groupTrack.devices[0].parameters[5].value = potValue

                # LFO - Y
                elif (controllerIndex == self._CC_CHANNEL_CHOP_RATE):
                    groupTrack.devices[0].parameters[6].value = potValue

                # LFO - X
                elif (controllerIndex == self._CC_CHANNEL_CHOP_AMMOUNT):
                    groupTrack.devices[0].parameters[7].value = potValue

                # MISC - Y (these are handled internally depending on the changel / instrument)
                elif (controllerIndex == self._CC_CHANNEL_Y):
                    if (channelIndex >= 0 and channelIndex <= 3):
                        stuff1 = self._CLIP_LENGTHS["000"]
                        #thisClipShit = self.song().tracks[0].clip_slots[0].clip
                        self.logger.log("---------------->  nem stuff=" + str(stuff1))
                        self.logger.log("---------------->  nem thisClipShit A =" + str(self.song().tracks[0].clip_slots[0]))
                        self.logger.log("---------------->  nem thisClipShit B =" + str(hash(self.song().tracks[0].clip_slots[0])))
                        self.logger.log("---------------->  nem thisClipShit C =" + str(id(self.song().tracks[0].clip_slots[0])))
                        #self.logger.log("---------------->  nem thisClipShit D =" + pickle.dumps(self.song().tracks[0].clip_slots[0]))
                        
                         
#                        clip = self.song().tracks[4].clip_slots[0].clip
#                        endValueRaw = (float(potValue) / float(127)) * 16
#                        endValue = round(endValueRaw, 1)
#                        clip.loop_end  = endValue

#                        playingClips = self.GetPlayingClipsForChannel(channelIndex)
#                        if (playingClips != None):
#                            #self.logger.log("---------------->  playingClips=" + str(playingClips))
#                            for playingClip in playingClips:
#                                #self.logger.log("---------------->  playingClip=" + str(playingClip.name))
#                                shit = self._CLIP_LENGTHS[str(id(playingClip))]
#                                #self.logger.log("---------------->  playingClip")
#                                #self.logger.log("---------------->  playingClip=" + str(playingClip.name))
#                                #self.logger.log("---------------->  playingClip=" + str(playingClip.name) + " self._CLIP_LENGTHS=" + str(len(self._CLIP_LENGTHS)))
#                                #self.logger.log("---------------->  playingClip=" + str(playingClip.name) + " self._CLIP_LENGTHS=" + str(len(self._CLIP_LENGTHS)))
#                                self.logger.log("---------------->  playingClip=" + str(playingClip.name) + " shit=" + str(shit))
                            
                # MESC - X (these are handled internally depending on the changel / instrument)
                elif (controllerIndex == self._CC_CHANNEL_X):
                    if (channelIndex >= 0 and channelIndex <= 3):
                        clip = self.song().tracks[4].clip_slots[0].clip
                        startValueRaw = (float(potValue) / float(127)) * 16
                        startValue = round(startValueRaw, 1)
                        clip.loop_start = startValueRaw


                # SEND A
                elif (controllerIndex == self._CC_FX_SEND_A):
                    sendAmmount = (float(potValue) / float(127)) * float(1)
                    groupTrack.mixer_device.sends[0].value = sendAmmount
                # SEND B
                elif (controllerIndex == self._CC_FX_SEND_B):
                    sendAmmount = (float(potValue) / float(127)) * float(1)
                    groupTrack.mixer_device.sends[1].value = sendAmmount
                # SEND C
                elif (controllerIndex == self._CC_FX_SEND_C):
                    sendAmmount = (float(potValue) / float(127)) * float(1)
                    groupTrack.mixer_device.sends[2].value = sendAmmount
                # SEND D
                elif (controllerIndex == self._CC_FX_SEND_D):
                    sendAmmount = (float(potValue) / float(127)) * float(1)
                    groupTrack.mixer_device.sends[3].value = sendAmmount

            elif (channelIndex == 8):
                self._appInstance.show_message("HandlePot MASTER > TRACK=" + str(channelIndex) + " CONTROLLER=" + str(controllerIndex)  + " VALUE=" + str(potValue))
                if (controllerIndex == 50):     # BPM
                    None
                elif (controllerIndex == 51):   # nothing
                    None
                elif (controllerIndex == 52):   # FX-A -> routing
                    clipIndex = int(round(float(potValue) / float(127) * float(self._CLIP_COUNT_FX_A-1), 0))
                    track = self.GetEffectTrack("A")
                    clipSlot = track.clip_slots[clipIndex]
                    if (clipSlot.clip.is_playing):
                        return
                    clipSlot.fire()
                elif (controllerIndex == 53):   # FX-B -> routing
                    clipIndex = int(round(float(potValue) / float(127) * float(self._CLIP_COUNT_FX_B-1), 0))
                    track = self.GetEffectTrack("B")
                    clipSlot = track.clip_slots[clipIndex]
                    if (clipSlot.clip.is_playing):
                        return
                    clipSlot.fire()
                elif (controllerIndex == 54):   # cue volume
                    None
                elif (controllerIndex == 55):   # master volume
                    None
                elif (controllerIndex == 56):   # FX-C -> routing
                    clipIndex = int(round(float(potValue) / float(127) * float(self._CLIP_COUNT_FX_C-1), 0))
                    track = self.GetEffectTrack("C")
                    clipSlot = track.clip_slots[clipIndex]
                    if (clipSlot.clip.is_playing):
                        return
                    clipSlot.fire()
                elif (controllerIndex == 57):   # FX-D -> routing
                    clipIndex = int(round(float(potValue) / float(127) * float(self._CLIP_COUNT_FX_D-1), 0))
                    track = self.GetEffectTrack("D")
                    clipSlot = track.clip_slots[clipIndex]
                    if (clipSlot.clip.is_playing):
                        return
                    clipSlot.fire()
            elif (channelIndex == 9):
                track = self.GetEffectTrack("A")
                if (track != None):
                    if (controllerIndex == 50):
                        track.devices[0].parameters[1].value = potValue
                    elif (controllerIndex == 51):
                        track.devices[0].parameters[2].value = potValue
                    elif (controllerIndex == 52):
                        track.devices[0].parameters[3].value = potValue
                    elif (controllerIndex == 53):
                        track.devices[0].parameters[4].value = potValue
            elif (channelIndex == 10):
                track = self.GetEffectTrack("B")
                if (track != None):
                    if (controllerIndex == 50):
                        track.devices[0].parameters[1].value = potValue
                    elif (controllerIndex == 51):
                        track.devices[0].parameters[2].value = potValue
                    elif (controllerIndex == 52):
                        track.devices[0].parameters[3].value = potValue
                    elif (controllerIndex == 53):
                        track.devices[0].parameters[4].value = potValue
            elif (channelIndex == 11):
                track = self.GetEffectTrack("C")
                if (track != None):
                    if (controllerIndex == 50):
                        track.devices[0].parameters[1].value = potValue
                    elif (controllerIndex == 51):
                        track.devices[0].parameters[2].value = potValue
                    elif (controllerIndex == 52):
                        track.devices[0].parameters[3].value = potValue
                    elif (controllerIndex == 53):
                        track.devices[0].parameters[4].value = potValue
            elif (channelIndex == 12):
                track = self.GetEffectTrack("D")
                if (track != None):
                    if (controllerIndex == 50):
                        track.devices[0].parameters[1].value = potValue
                    elif (controllerIndex == 51):
                        track.devices[0].parameters[2].value = potValue
                    elif (controllerIndex == 52):
                        track.devices[0].parameters[3].value = potValue
                    elif (controllerIndex == 53):
                        track.devices[0].parameters[4].value = potValue
        except:
            self.logger.log("    ERROR >>> HandlePot channelIndex=" + str(channelIndex) + " controllerIndex=" + str(controllerIndex) + " potValue=" + str(potValue))
            
                

    # CHANNEL buttons are the 3 channel strip buttons.
    def HandleChannelButton(self, channelIndex, buttonIndex, buttonState):
        if (self._LOG_HANDLER_EVENTS):
            self.logger.log("HandleChannelButton > channelIndex=" + str(channelIndex) + " buttonIndex=" + str(buttonIndex)  + " buttonState=" + str(buttonState))
        try:
            if (buttonState == self._BUTTON_DOWN):
                groupTrack = self.GetGroupTrack(channelIndex)
                if (groupTrack == None):
                    return
                
                # FX ON/OFF
                if (buttonIndex == 11):
                    self.send_midi((self._NOTE_ON_EVENT + channelIndex, self._NOTE_SEND_OFFSET + 11, self._LED_WHITE))
                    if (self._EQ_STATES[channelIndex] == 1 and self._FX_STATES[channelIndex] == 1):
                        self._FX_STATES[channelIndex] = 0
                        groupTrack.clip_slots[1].fire()
                    elif (self._EQ_STATES[channelIndex] == 1 and self._FX_STATES[channelIndex] == 0):
                        self._FX_STATES[channelIndex] = 1
                        groupTrack.clip_slots[3].fire()
                    elif (self._EQ_STATES[channelIndex] == 0 and self._FX_STATES[channelIndex] == 1):
                        self._FX_STATES[channelIndex] = 0
                        groupTrack.clip_slots[0].fire()
                    else:
                        self._FX_STATES[channelIndex] = 1
                        groupTrack.clip_slots[2].fire()

#                # LOOP I/O
#                elif (buttonIndex == 0):
#                    None
#
                # LFO 0/1/2
                elif (buttonIndex == 1):    
                    currentLfoValue = groupTrack.devices[0].parameters[8].value;
                    if (currentLfoValue == 0 and currentLfoValue < 42):
                        groupTrack.devices[0].parameters[8].value = 42
                    elif (currentLfoValue >= 42 and currentLfoValue < 85):
                        groupTrack.devices[0].parameters[8].value = 85
                    else:
                        groupTrack.devices[0].parameters[8].value = 0
                    self.DisplayChannelButtonsForChannel(channelIndex)

                # EQ I/O
                elif (buttonIndex == 2):    
                    self.send_midi((self._NOTE_ON_EVENT + channelIndex, self._NOTE_SEND_OFFSET + 0, self._LED_WHITE))
                    if (self._EQ_STATES[channelIndex] == 1 and self._FX_STATES[channelIndex] == 1):
                        self._EQ_STATES[channelIndex] = 0
                        groupTrack.clip_slots[2].fire()
                    elif (self._EQ_STATES[channelIndex] == 1 and self._FX_STATES[channelIndex] == 0):
                        self._EQ_STATES[channelIndex] = 0
                        groupTrack.clip_slots[0].fire()
                    elif (self._EQ_STATES[channelIndex] == 0 and self._FX_STATES[channelIndex] == 1):
                        self._EQ_STATES[channelIndex] = 1
                        groupTrack.clip_slots[3].fire()
                    else:
                        self._EQ_STATES[channelIndex] = 1
                        groupTrack.clip_slots[1].fire()

        except:
            self.logger.log("    ERROR >>> HandleChannelButton channelIndex=" + str(channelIndex) + " buttonIndex=" + str(buttonIndex) + " buttonState=" + str(buttonState))
            


    # CLIP buttons are the 8x8 clip matrix buttons.
    def HandleClipButton(self, channelIndex, clipIndex, buttonState):
        if (self._LOG_HANDLER_EVENTS):
            self.logger.log("HandleClipButton > channelIndex=" + str(channelIndex) + " clipIndex=" + str(clipIndex)  + " buttonState=" + str(buttonState))
        try:
            if (buttonState == self._BUTTON_DOWN):
                clipSlotIndex = clipIndex - 3 + (self._CURRENT_SONG * self._SCENES_PER_SONG)
                if (clipIndex == 10):     # STOP BUTTON
                    self._LAST_TRIGGERED_CLIPS[channelIndex] = 0
                    for track in self.song().tracks:
                        channel = self.GetTrackChannel(track)
                        if (channel == None):
                            continue
                        if (channel != channelIndex):
                            continue
                        selectedClipSlot = track.clip_slots[clipSlotIndex]
                        selectedClipSlot.fire()
                    self.DisplaClipsForChannel(channelIndex)
                else:
                    if (self._LAST_TRIGGERED_CLIPS[channelIndex] == 1):
                        return
                    for track in self.song().tracks:
                        channel = self.GetTrackChannel(track)
                        if (channel == None):
                            continue
                        if (channel != channelIndex):
                            continue
                        selectedClipSlot = track.clip_slots[clipSlotIndex]
                        selectedClipSlot.fire()
                        if (selectedClipSlot.has_clip):
                            self._LAST_TRIGGERED_CLIPS[channelIndex] = 1
                            self.send_midi((self._NOTE_ON_EVENT + channelIndex, clipIndex + self._NOTE_SEND_OFFSET, self._LED_YELLOW))
        except:
            self._LAST_TRIGGERED_CLIPS[channelIndex] = 0
            self.logger.log("    ERROR >>> HandleClipButton channelIndex=" + str(channelIndex) + " clipIndex=" + str(clipIndex)  + " buttonState=" + str(buttonState))
                
                    



             


            
    # SYSTEM buttons are the 2 horizontal rows of 16 buttons in the master section. 
    def HandleSystemButton(self, buttonIndex, buttonState):
        if (self._LOG_HANDLER_EVENTS):
            self.logger.log("HandleSystemButton > buttonIndex=" + str(buttonIndex)  + " buttonState=" + str(buttonState))
        try:
            if (buttonState == self._BUTTON_DOWN):
                
                # Song Selects 1-16
                if (buttonIndex == 16):
                    self.SetCurrentSong(0)
                elif (buttonIndex == 17):
                    self.SetCurrentSong(1)
                elif (buttonIndex == 18):
                    self.SetCurrentSong(2)
                elif (buttonIndex == 19):
                    self.SetCurrentSong(3)
                elif (buttonIndex == 23):
                    self.SetCurrentSong(4)
                elif (buttonIndex == 22):
                    self.SetCurrentSong(5)
                elif (buttonIndex == 21):
                    self.SetCurrentSong(6)
                elif (buttonIndex == 20):
                    self.SetCurrentSong(7)
                elif (buttonIndex == 24):
                    self.SetCurrentSong(8)
                elif (buttonIndex == 25):
                    self.SetCurrentSong(9)
                elif (buttonIndex == 26):
                    self.SetCurrentSong(10)
                elif (buttonIndex == 27):
                    self.SetCurrentSong(11)
                elif (buttonIndex == 31):
                    self.SetCurrentSong(12)
                elif (buttonIndex == 30):
                    self.SetCurrentSong(13)
                elif (buttonIndex == 29):
                    self.SetCurrentSong(14)
                elif (buttonIndex == 28):
                    self.SetCurrentSong(15)
                    
                elif (buttonIndex == 4):
                    # TRANSPORT - play
                    self.song().start_playing()
                elif (buttonIndex == 5):
                    # TRANSPORT - stop
                    self.song().stop_playing()
                elif (buttonIndex == 6):
                    # TRANSPORT - rec
                    if (self.song().record_mode == 0):
                        self.song().record_mode = 1
                    else:
                        self.song().record_mode = 0
                elif (buttonIndex == 7):
                    # TEMPO - nudge down
                    None
                elif (buttonIndex == 0):
                    # TEMPO - down
                    self.song().tempo = self.song().tempo -0.5
                elif (buttonIndex == 1):
                    # TEMPO - tap
                    None
                elif (buttonIndex == 2):
                    # TEMPO - up
                    self.song().tempo = self.song().tempo +0.5
                elif (buttonIndex == 3):
                    # TEMPO - nudge up
                    None
                elif (buttonIndex == 8):
                    # MASTER-FX TOGGLE REPEAT ON/OFF
                    self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 25, self._LED_WHITE))
                    masterTrack = self.song().tracks[len(self.song().tracks)-1]
                    if (self._MASTER_FX_STATE == 0):     # 0 | 0
                        self._MASTER_FX_STATE = 1
                        masterTrack.clip_slots[1].fire()
                    elif (self._MASTER_FX_STATE == 1):   # 1 | 0
                        self._MASTER_FX_STATE = 0
                        masterTrack.clip_slots[0].fire()
                    elif (self._MASTER_FX_STATE == 2):   # 0 | 1
                        self._MASTER_FX_STATE = 3
                        masterTrack.clip_slots[3].fire()
                    elif (self._MASTER_FX_STATE == 3):   # 1 | 1
                        self._MASTER_FX_STATE = 2
                        masterTrack.clip_slots[2].fire()
                elif (buttonIndex == 9):
                    # MASTER-FX TOGGLE CHORUS ON/OFF
                    self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 26, self._LED_WHITE))
                    masterTrack = self.song().tracks[len(self.song().tracks)-1]
                    if (self._MASTER_FX_STATE == 0):     # 0 | 0
                        self._MASTER_FX_STATE = 2
                        masterTrack.clip_slots[2].fire()
                    elif (self._MASTER_FX_STATE == 1):   # 1 | 0
                        self._MASTER_FX_STATE = 3
                        masterTrack.clip_slots[3].fire()
                    elif (self._MASTER_FX_STATE == 2):   # 0 | 1
                        self._MASTER_FX_STATE = 0
                        masterTrack.clip_slots[0].fire()
                    elif (self._MASTER_FX_STATE == 3):   # 1 | 1
                        self._MASTER_FX_STATE = 1
                        masterTrack.clip_slots[1].fire()
                elif (buttonIndex == 10):
#                    # CURSOR - left
#                    nav = Live.Application.Application.View.NavDirection
#                    self.application().view.zoom_view(nav.left, '', None)
                    None
                elif (buttonIndex == 11):
#                    # CURSOR - up
#                    nav = Live.Application.Application.View.NavDirection
#                    self.application().view.zoom_view(nav.up, '', None)
                    None
                elif (buttonIndex == 15):
#                    # CURSOR - down
#                    nav = Live.Application.Application.View.NavDirection
#                    self.application().view.zoom_view(nav.down, '', None)
                    None
                elif (buttonIndex == 14):
#                    # CURSOR - right
#                    nav = Live.Application.Application.View.NavDirection
#                    self.application().view.zoom_view(nav.right, '', None)
                    None
                elif (buttonIndex == 13):
                    None
                elif (buttonIndex == 12):
                    # KILL MASTER VOLUME 
                    masterTrack = self.song().tracks[len(self.song().tracks)-1]
                    self.ToggleDeviceParameter(masterTrack.devices[1], "Mute")
                    muted = self.GetDeviceParameter(masterTrack.devices[1], "Mute")
                    if (muted == 1):
                        self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 32, self._LED_RED))
                    else:
                        self.send_midi((self._NOTE_ON_EVENT + 0x08, self._NOTE_SEND_OFFSET + 32, self._LED_OFF))
        except:
            self.logger.log("    ERROR >>> HandleSystemButton > buttonIndex=" + str(buttonIndex)  + " buttonState=" + str(buttonState))




    

















    # Here we display the currently selected song in the system buttons row.
    def DisplayCurrentSong(self):
        self._appInstance.show_message("SONG >>> index=" + str(self._CURRENT_SONG) + " name=" + str(self.song().view.selected_scene.name))
        try:
            self.send_midi((self._NOTE_ON_EVENT + 0x08, self._CURRENT_SONG + self._NOTE_SEND_OFFSET, self._LED_CYAN))  # channel 9, song number
        except:
            self.logger.log("    ERROR >>> DisplayCurrentSong > SONG=" + str(self._CURRENT_SONG))



    # Here I calculate if the beat has changed. 
    # Will eventually forward a MIDI message to one of the LED buttons so it flashes in time with current BPM.
    def DisplayTempo(self):
        try:
            beatTime = self.song().get_current_beats_song_time()
            if (beatTime.bars != self._LAST_BAR):
                if (self._LOG_TEMPO_EVENTS):
                    self.logger.log(">>> DisplayTempo BARS=" + str(beatTime.bars))
                self._LAST_BAR = beatTime.bars
            if (beatTime.beats != self._LAST_BEAT):
                if (self._LOG_TEMPO_EVENTS):
                    self.logger.log(">>> DisplayTempo BEATS=" + str(beatTime.beats))
                self._LAST_BEAT = beatTime.beats
        except:
            self.logger.log("    ERROR >>> DisplayTempo")



    # Send status of the 3 channel strip buttons. 
    def DisplayChannelButtons(self):
        if (self._LOG_DISPLAY_EVENTS):
            self.logger.log(">>> DisplayChannelButtons")
        if (self._IGNORE_DISPLAY_CHANNELS == 1):
            return
        try:
            self._IGNORE_DISPLAY_CHANNELS = 1
            for channelIndex in range (0, 8):
                self.DisplayChannelButtonsForChannel(channelIndex)
            self._IGNORE_DISPLAY_CHANNELS = 0
        except:
            self._IGNORE_DISPLAY_CHANNELS = 0
            self.logger.log("    ERROR >>> DisplayChannelButtons ERROR!!!")


    def DisplayChannelButtonsForChannel(self, channelIndex):
        try:
            if (self._DISCONNECTED):
                return
            groupTrack = self.GetGroupTrack(channelIndex)
            if (groupTrack.clip_slots[0].clip.is_playing == False
                and groupTrack.clip_slots[1].clip.is_playing == False
                and groupTrack.clip_slots[2].clip.is_playing == False
                and groupTrack.clip_slots[3].clip.is_playing == False):
                None
            if (groupTrack.clip_slots[0].clip.is_triggered == True
                or groupTrack.clip_slots[1].clip.is_triggered == True
                or groupTrack.clip_slots[2].clip.is_triggered == True
                or groupTrack.clip_slots[3].clip.is_triggered == True):
                None
            else:
                if (self._EQ_STATES[channelIndex] == 1 and self._FX_STATES[channelIndex] == 1):   
                    self.send_midi((self._NOTE_ON_EVENT + channelIndex, self._NOTE_SEND_OFFSET + 0, self._LED_YELLOW))
                    self.send_midi((self._NOTE_ON_EVENT + channelIndex, self._NOTE_SEND_OFFSET + 11, self._LED_MAGENTA))
                elif (self._EQ_STATES[channelIndex] == 1 and self._FX_STATES[channelIndex] == 0):   
                    self.send_midi((self._NOTE_ON_EVENT + channelIndex, self._NOTE_SEND_OFFSET + 0, self._LED_YELLOW))
                    self.send_midi((self._NOTE_ON_EVENT + channelIndex, self._NOTE_SEND_OFFSET + 11, self._LED_OFF))
                elif (self._EQ_STATES[channelIndex] == 0 and self._FX_STATES[channelIndex] == 1):   
                    self.send_midi((self._NOTE_ON_EVENT + channelIndex, self._NOTE_SEND_OFFSET + 0, self._LED_OFF))
                    self.send_midi((self._NOTE_ON_EVENT + channelIndex, self._NOTE_SEND_OFFSET + 11, self._LED_MAGENTA))
                else:
                    self.send_midi((self._NOTE_ON_EVENT + channelIndex, self._NOTE_SEND_OFFSET + 0, self._LED_OFF))
                    self.send_midi((self._NOTE_ON_EVENT + channelIndex, self._NOTE_SEND_OFFSET + 11, self._LED_OFF))

            currentLfoValue = groupTrack.devices[0].parameters[8].value;
            if (currentLfoValue == 0 and currentLfoValue < 42):
                self.send_midi((self._NOTE_ON_EVENT + channelIndex, self._NOTE_SEND_OFFSET + 1, self._LED_OFF))
            elif (currentLfoValue >= 42 and currentLfoValue < 85):
                self.send_midi((self._NOTE_ON_EVENT + channelIndex, self._NOTE_SEND_OFFSET + 1, self._LED_BLUE))
            else:
                self.send_midi((self._NOTE_ON_EVENT + channelIndex, self._NOTE_SEND_OFFSET + 1, self._LED_CYAN))

        except:
            self.logger.log("    ERROR >>> DisplayChannelButtonsForChannel ERROR!!! channelIndex=" + str(channelIndex))
        

  



    def DisplayClipButtons(self):
        if (self._LOG_DISPLAY_EVENTS):
            self.logger.log(">>> DisplayClipButtons")
        try:
            if (self._IGNORE_DISPLAY_CLIPS  == 1):
                return
            self._IGNORE_DISPLAY_CLIPS = 1
            for channelIndex in range (0, 8):
                self.DisplaClipsForChannel(channelIndex)
            self._IGNORE_DISPLAY_CLIPS = 0
        except:
            self._IGNORE_DISPLAY_CLIPS = 0
            self.logger.log("    ERROR >>> DisplayClipButtons ERROR!!!")




    def DisplaClipsForChannel(self, channelIndex):
        try:
            for buttonIndex in range (0, 7):
                clipSlotIndex = buttonIndex + (self._CURRENT_SONG * self._SCENES_PER_SONG)
                clipStatus = self.GetChannelClipStatus(channelIndex, clipSlotIndex)
                
                if (clipStatus == self._CLIP_STATUS_ARMED):
                    self.send_midi((self._NOTE_ON_EVENT + channelIndex, buttonIndex + 3 + self._NOTE_SEND_OFFSET, self._LED_RED))
                elif (clipStatus == self._CLIP_STATUS_TRIGGERED):
                    # I'm only showing triggered when the button is pressed or the event fired internally.
                    self.send_midi((self._NOTE_ON_EVENT + channelIndex, buttonIndex + 3 + self._NOTE_SEND_OFFSET, self._LED_BLUE))
                elif (clipStatus == self._CLIP_STATUS_PLAYING):
                    self.send_midi((self._NOTE_ON_EVENT + channelIndex, buttonIndex + 3 + self._NOTE_SEND_OFFSET, self._LED_GREEN))
                elif (clipStatus == self._CLIP_STATUS_PRESENT):
                    self.send_midi((self._NOTE_ON_EVENT + channelIndex, buttonIndex + 3 + self._NOTE_SEND_OFFSET, self._LED_BLUE))
                elif (clipStatus == self._CLIP_STATUS_NONE):
                    self.send_midi((self._NOTE_ON_EVENT + channelIndex, buttonIndex + 3 + self._NOTE_SEND_OFFSET, self._LED_OFF))
            self.send_midi((self._NOTE_ON_EVENT + channelIndex, self._NOTE_SEND_OFFSET + 10, self._LED_GREEN))
        except:
            self.logger.log("    ERROR >>> DisplaClipsForChannel channelIndex=" + str(channelIndex))
   











 

    # Util that gathers the number of clips for the 4 effect tracks.
    def GetEffectChannelClipCounts(self):
        try:
            trackFxA = self.GetEffectTrack("A")
            trackFxB = self.GetEffectTrack("B")
            trackFxC = self.GetEffectTrack("C")
            trackFxD = self.GetEffectTrack("D")
            self._CLIP_COUNT_FX_A = self.GetClipCountForTrack(trackFxA)
            self._CLIP_COUNT_FX_B = self.GetClipCountForTrack(trackFxB)
            self._CLIP_COUNT_FX_C = self.GetClipCountForTrack(trackFxC)
            self._CLIP_COUNT_FX_D = self.GetClipCountForTrack(trackFxD)
        except:
            self.logger.log("    ERROR >>> GetEffectChannelClipCounts")
    
    
    
    # Util that returns the number of populated clip slots in the given track index.
    def GetClipCountForTrack(self, track):
        result = 0
        for clip_slot in track.clip_slots:
            if (clip_slot.has_clip == 0):
                return result
            result += 1
        return result




    # Here we set the current song(scene) to the given song(scene) index.
    def SetCurrentSong(self, songIndex):
        try:
            self.application().view.show_view("Session")
            self.application().view.focus_view("Session")
            nav = Live.Application.Application.View.NavDirection
            self._CURRENT_SONG = songIndex
            self.song().view.selected_scene = self.song().scenes[self._CURRENT_SONG * self._SCENES_PER_SONG]
            if (self._CHANGE_TEMPO_ON_SONG_CHANGE == 1):
                self.song().tempo = self.song().view.selected_scene.tempo
            self.DisplayCurrentSong()
            self.DisplayClipButtons()
            self.UpdateInstrumentChains()
        except:
            self.logger.log("    ERROR >>> SetCurrentSong songIndex=" + str(songIndex))


    # Here we set each tracks chain depending on the given song index.
    def UpdateInstrumentChains(self):
        try:
            for track in self.song().tracks:
                channel = self.GetTrackChannel(track)
                if (channel == None):
                    continue
                clipTriggered = self.TrackHasTriggeredClip(track)
                clipPlaying = self.TrackHasPlayingClip(track)
                if (clipPlaying):
                    if (clipTriggered):
                        track.devices[0].parameters[9].value = self._CURRENT_SONG
                else:
                    track.devices[0].parameters[9].value = self._CURRENT_SONG
        except:
            self.logger.log("    ERROR >>> UpdateInstrumentChains")
    




    # Here we assign the real-world values contained within the song to the in-memory ones.
    # This is so we can restore and display the previous state in the deck when loading up a song.
    def GatherSongState(self):
        try:
            if (self._LOG_LISTENER_EVENTS):
                self.logger.log("GatherSongState")
            for channel in range(0, 8):
                groupTrack = self.GetGroupTrack(channel)
                if (groupTrack == None):
                    continue
                if (groupTrack.clip_slots[3].clip.is_playing or groupTrack.clip_slots[3].clip.is_triggered):
                    self._EQ_STATES[channel] = 1
                    self._FX_STATES[channel] = 1
                elif (groupTrack.clip_slots[2].clip.is_playing or groupTrack.clip_slots[2].clip.is_triggered):
                    self._EQ_STATES[channel] = 0
                    self._FX_STATES[channel] = 1
                elif (groupTrack.clip_slots[1].clip.is_playing or groupTrack.clip_slots[1].clip.is_triggered):
                    self._EQ_STATES[channel] = 1
                    self._FX_STATES[channel] = 0
                else:
                    self._EQ_STATES[channel] = 0
                    self._FX_STATES[channel] = 0
        except:
            self.logger.log("    ERROR >>> GatherSongState")



    def ResetEffectClips(self):
        try:
            effectTrackA = self.GetEffectTrack("A")
            if (effectTrackA != None):
                effectTrackAClipPlaying = self.TrackHasPlayingClip(effectTrackA)
                effectTrackAClipTriggered = self.TrackHasTriggeredClip(effectTrackA)
                if (effectTrackAClipPlaying and effectTrackAClipTriggered):
                    effectTrackA.clip_slots[0].fire()
            effectTrackB = self.GetEffectTrack("B")
            if (effectTrackB != None):
                effectTrackBClipPlaying = self.TrackHasPlayingClip(effectTrackB)
                effectTrackBClipTriggered = self.TrackHasTriggeredClip(effectTrackB)
                if (effectTrackBClipPlaying and effectTrackBClipTriggered):
                    effectTrackB.clip_slots[0].fire()
            effectTrackC = self.GetEffectTrack("C")
            if (effectTrackC != None):
                effectTrackCClipPlaying = self.TrackHasPlayingClip(effectTrackC)
                effectTrackCClipTriggered = self.TrackHasTriggeredClip(effectTrackC)
                if (effectTrackCClipPlaying and effectTrackCClipTriggered):
                    effectTrackC.clip_slots[0].fire()
            effectTrackD = self.GetEffectTrack("D")
            if (effectTrackD != None):
                effectTrackDClipPlaying = self.TrackHasPlayingClip(effectTrackD)
                effectTrackDClipTriggered = self.TrackHasTriggeredClip(effectTrackD)
                if (effectTrackDClipPlaying and effectTrackDClipTriggered):
                    effectTrackD.clip_slots[0].fire()
        except:
            self.logger.log("    ERROR >>> ResetEffectClips")



    def ResetMasterClips(self):
        try:
            masterTrack = self.song().tracks[len(self.song().tracks) -1]
            if (masterTrack != None):
                masterTrackClipPlaying = self.TrackHasPlayingClip(masterTrack)
                masterTrackClipTriggered = self.TrackHasTriggeredClip(masterTrack)
                if (masterTrackClipPlaying and masterTrackClipTriggered):
                    masterTrack.clip_slots[0].fire()
        except:
            self.logger.log("    ERROR >>> ResetMasterClips")


    def GatherClipLengths(self):
        try:
            #self._CLIP_LENGTHS = [[0,0]]
            self._CLIP_LENGTHS = {"000":-1}
            for track in self.song().tracks:
                if (track.has_midi_input):
                    continue
                channelIndex = self.GetTrackChannel(track)
                if (channelIndex == None):
                    continue
                for clipSlot in track.clip_slots:
                    if not (clipSlot.has_clip):
                        continue
                    try:
                        #self.logger.log("------------------> GatherClipLengths track=" + str(track.name) + " clip=" + str(clipSlot.clip.name) + " looping=" + str(clipSlot.clip.looping)) 
                        isLooping = clipSlot.clip.looping
                        clipSlot.clip.looping = False
                        self._CLIP_LENGTHS[str(id(clipSlot.clip))] = clipSlot.clip.length
                        #self._CLIP_LENGTHS.append( [str(id(clipSlot.clip)), clipSlot.clip.length] )
                        clipSlot.clip.looping = isLooping
                    except:
                        self.logger.log("    ERROR >>> GatherClipLengths track=" + str(track.name) + " clip=" + str(clipSlot.clip.name)) 
        except:
            self.logger.log("    ERROR >>> GatherClipLengths")











    # Util that gets/changes the coarse and fine pitch shift of clip (clip) in track (track).
    # If (coarse) or (fine) are specified, changes the clip's pitch.
    def clipPitch(track, clip, coarse = None, fine = None):
        try:
            thisClip = self.song().tracks[track].clip_slots[clip].clip
            if coarse != None:
                thisClip.pitch_coarse = coarse
            if fine != None:
                thisClip.pitch_fine = fine
            return (thisClip.pitch_coarse, thisClip.pitch_fine)
        except:
            self.logger.log("    ERROR >>> clipPitch track.name=" + str(track.name) + " clip.name=" + str(clip.name) )
            return None

    # Util that gets the device on the given track by the given name.
    def GetDeviceByName(self, track, deviceName):
        try:
            for device in track.devices:
                if (device.name == deviceName):
                    return device
            return None
        except:
            self.logger.log("    ERROR >>> GetDeviceByName track=" + str(track.Name) + " deviceName=" + str(deviceName))
            return None



    # Util that gets the value of the given device in the given track by the given parameter name. 
    def GetDeviceParameter(self, device, paramName):
        try:
            for deviceParam in device.parameters:
                if (deviceParam.name == paramName):
                    return deviceParam.value
            return None
        except:
            self.logger.log("    ERROR >>> GetDeviceParameter device.name=" + str(device.name) + " paramName=" + str(paramName))
            return None

    # Util that sets the given parameter name of the given device to the given value.
    def SetDeviceParameter(self, device, paramName, value):
        try:
            for deviceParam in device.parameters:
                if (deviceParam.name == paramName):
                    deviceParam.value = value
                    pass
        except:
            self.logger.log("    ERROR >>> SetDeviceParameter device.name=" + str(device.name) + " paramName=" + str(paramName) + " value=" + str(value))

    # Util that toggles the given param of the given device. Usefull for on/off effects, etc.
    def ToggleDeviceParameter(self, device, paramName):
        try:
            for deviceParam in device.parameters:
                if (deviceParam.name == paramName):
                    if (deviceParam.value == 1):
                        deviceParam.value = 0
                    else:
                        deviceParam.value = 1
                    pass
        except:
            self.logger.log("    ERROR >>> ToggleDeviceParameter device.name=" + str(device.name) + " paramName=" + str(paramName))

    # Util that toggles the given sendindex of the given track from min to max value.
    def ToggleSendValue(self, track, sendIndex):
        try:
            currentValue = track.mixer_device.sends[sendIndex].value
            if (currentValue == 1):
                track.mixer_device.sends[sendIndex].value = 0
            else:
                track.mixer_device.sends[sendIndex].value = 1
        except:
            self.logger.log("    ERROR >>> ToggleSendValue track.name=" + str(track.name) + " sendIndex=" + str(sendIndex))

    # Util that returns if the given track has a triggered clip.
    def TrackHasTriggeredClip(self, track):
        try:
            for clipSlot in track.clip_slots:
                if (clipSlot.has_clip):
                    if (clipSlot.clip.is_triggered):
                        return True
            return False
        except:
            self.logger.log("    ERROR >>> TrackHasTriggeredClip track.name=" + str(track.name))
            return False


    # Util that returns if the given track has a playing clip.
    def TrackHasPlayingClip(self, track):
        try:
            for clipSlot in track.clip_slots:
                if (clipSlot.has_clip):
                    if (clipSlot.clip.is_playing):
                        return True
            return False
        except:
            self.logger.log("    ERROR >>> TrackHasPlayingClip track.name=" + str(track.name))
            return False




               

    # returns the numbered index of the given track within the current song.
    def GetTrackIndex(self, thatTrack):
        try:
            for x in len(self.song().tracks):
                thisTrack = self.song().tracks[x]
                #if (thisTrack.name == thatTrack.name):
                if id(thisTrack) == id(thatTrack):
                    return x
                return None
        except:
            self.logger.log("    ERROR >>> GetTrackIndex track.name=" + str(track.name))
            return None

  


  
    # Util that gets the assigned channel for the given track. For the 8 group tracks this would be nothing.
    def GetTrackChannel(self, track):
        try:
            if (track.has_audio_output != 1):
                return None     # so we skip midi tracks
            if (len(str(track.current_input_routing)) < 1):
                return None     # so we skip return tracks
            if (str(track.current_output_routing) == "Master"):
                return None     # so we skip master/return tracks
            if (str(track.name).find("~") > -1):
                return None     # so we skip fx tracks which have a '~' at the end of their track name
            if (str(track.name).find("_") < 1):
                return None     # so we skip audio tracks which dont have a '_' in their track name (like ad-hoc audio tracks)
            return int(track.current_output_routing.split('-')[1])-1
        except:
            self.logger.log("    ERROR >>> GetTrackChannel > track=" + str(track.Name))
            return None



    # returns the main group channel matching the given channel index.
    def GetGroupTrack(self, channelIndex):
        try:
            for track in self.song().tracks:
                try:
                    if not (track.has_audio_output):
                        continue    # so we only get audio tracks
                    if (len(str(track.current_input_routing)) < 1):
                        continue    # so we skip return tracks
                    groupTrackName = track.name
                    if (len(groupTrackName) > 2):   # all group tracks are named as their channel index ('1' to '8')
                        continue    # so we skip any other audio tracks that aren't group tracks
                    groupTrackNumber = int(groupTrackName[0])-1    # channelIndex is zero-based
                    if (groupTrackNumber == channelIndex):   
                        return track
                except:
                    self.logger.log("    ERROR >>> GetGroupTrack > channelIndex=" + str(channelIndex) + " track=" + str(track.name))
                    return None
            return None
        except:
            self.logger.log("    ERROR >>> GetGroupTrack > channelIndex=" + str(channelIndex))
            return None





    # returns the effect track for the given effect name ("A", "B", "C", "D").
    def GetEffectTrack(self, effectName):
        try:
            for track in self.song().tracks:
                if (track.name.find("FX_") < 0):
                    continue    # so we skip all non-fx named tracks
                if not (track.has_audio_output):
                    continue    # so we only get audio tracks
                if (len(str(track.current_input_routing)) < 1):
                    continue    # so we skip return tracks
                effectTrackname = track.name.split('_')[1][0]
                if (effectName == effectTrackname):   
                    return track
            return None
        except:
            self.logger.log("    ERROR >>> GetEffectTrack > effectIndex=" + str(effectIndex))
            return None

  
    # scans all the tracks assigned to the given channel and returns the status of the given clip slot index.
    # returns the value based on a priority list so we get the most relevent info first.
    def GetChannelClipStatus(self, channelIndex, clipIndex):
        try:
            for track in self.song().tracks:
                if (track.has_audio_output != 1):
                    continue    # so we skip midi tracks
                trackChannel = self.GetTrackChannel(track)
                if (trackChannel == None):
                    continue    # so we skip master/send and non clip tracks
                if (trackChannel != channelIndex):
                    continue    # so we only look at tracks that are routed to the given channel
                clipSlot = track.clip_slots[clipIndex]
                if (clipSlot.has_clip):
                    if (clipSlot.clip.is_triggered):
                        return self._CLIP_STATUS_TRIGGERED
                    elif (clipSlot.clip.is_playing):
                        if (track.arm):
                            return self._CLIP_STATUS_ARMED
                        else:
                            return self._CLIP_STATUS_PLAYING
                    else:
                        return self._CLIP_STATUS_PRESENT
            return self._CLIP_STATUS_NONE
        except:
            self.logger.log("    ERROR >>> GetChannelClipStatus > channelIndex=" + str(channelIndex) + " clipIndex=" + str(clipIndex))
            return None
            

    def GetPlayingClipsForChannel(self, channelIndex):
        try:
            result = list()
            for track in self.song().tracks:
                if (track.has_audio_output != 1):
                    continue    # so we skip midi tracks
                trackChannel = self.GetTrackChannel(track)
                if (trackChannel == None):
                    continue    # so we skip master/send and non clip tracks
                if (trackChannel != channelIndex):
                    continue    # so we only look at tracks that are routed to the given channel
                for clipSlot in track.clip_slots:
                    if (clipSlot.has_clip == 0):
                        continue
                    if (clipSlot.clip.is_playing):
                        result.append(clipSlot.clip)
                        break
            return result
        except:
            self.logger.log("    ERROR >>> GetPlayingClipsForChannel > channelIndex=" + str(channelIndex))
            return None








