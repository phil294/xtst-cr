# require "x11"

module Xtst::C
  @[Link("X11")]
  lib Xtst
    fun record_query_version = XRecordQueryVersion(
      dpy : PDisplay,
      major_version : Int32*,
      minor_version : Int32*
    ) : Status

    fun record_alloc_range = XRecordAllocRange() : RecordRange*
    struct RecordRange
      core_requests : RecordRange8
      core_replies : RecordRange8
      ext_requests : RecordExtRange
      ext_replies : RecordExtRange
      delivered_events : RecordRange8
      device_events : RecordRange8
      errors : RecordRange8
      client_started : Bool
      client_died : Bool
    end
    struct RecordRange8
      first : CChar
      last : CChar
    end
    struct RecordRange16
      first : UInt16
      last : UInt16
    end
    struct RecordExtRange
      ext_major : RecordRange8
      ext_minor : RecordRange16
    end
    
    enum RecordClientSpec
      CurrentClients = 1
      FutureClients
      AllClients
    end
    
    alias RecordContext = UInt64
    fun record_create_context = XRecordCreateContext(
      dpy : PDisplay,
      flags : Int32,
      clients : RecordClientSpec*,
      n_clients : Int32,
      ranges : RecordRange**,
      n_ranges : Int32
    ) : RecordContext
    
    fun record_enable_context_async = XRecordEnableContextAsync(
      dpy : PDisplay,
      context : RecordContext,
      callback : RecordInterceptProc,
      client_data : Void*
    ) : Status
    alias RecordInterceptProc = Void*, RecordInterceptData* ->
    struct RecordInterceptData
      id_base : XID
      server_time : Time
      client_seq : UInt64
      category : Int32
      client_swapped : Bool
      data : Pointer
      data_len : UInt64
    end
    
    fun record_process_replies = XRecordProcessReplies(
      dpy : PDisplay
    ) : Void
    
    enum RecordInterceptDataCategory
      FromServer
      FromClient
      ClientStarted
      ClientDied
      StartOfData
      EndOfData
    end

  end

end
