require "x11"

module Xtst::C
  include ::X11::C

  @[Link("Xtst")]
  lib LibXtst
    fun record_query_version = XRecordQueryVersion(
      dpy : X::PDisplay,
      major_version : PInt32,
      minor_version : PInt32
    ) : X::Status

    fun record_alloc_range = XRecordAllocRange() : RecordRange*
    struct RecordRange
      core_requests : RecordRange8
      core_replies : RecordRange8
      ext_requests : RecordExtRange
      ext_replies : RecordExtRange
      delivered_events : RecordRange8
      device_events : RecordRange8
      errors : RecordRange8
      client_started : X11::X::Bool
      client_died : X11::X::Bool
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
      dpy : X::PDisplay,
      flags : Int32,
      clients : RecordClientSpec*,
      n_clients : Int32,
      ranges : RecordRange**,
      n_ranges : Int32
    ) : RecordContext
    
    fun record_enable_context_async = XRecordEnableContextAsync(
      dpy : X::PDisplay,
      context : RecordContext,
      callback : RecordInterceptProc,
      client_data : Void*
    ) : X::Status
    alias RecordInterceptProc = Void*, RecordInterceptData* ->
    struct RecordInterceptData
      id_base : XID
      server_time : Time
      client_seq : UInt64
      category : Int32
      client_swapped : X11::X::Bool
      data : X::Pointer
      data_len : UInt64
    end
    
    fun record_process_replies = XRecordProcessReplies(
      dpy : X::PDisplay
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
