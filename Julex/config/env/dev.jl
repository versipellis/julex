using Genie.Configuration

const config =  Settings(
                  assets_path         = "/",
                  cache_duration      = 0,
                  log_cache           = true,
                  log_formatted       = true,
                  log_level           = :debug,
                  log_router          = false,
                  log_verbosity       = LOG_LEVEL_VERBOSITY_VERBOSE,
                  log_views           = true,
                  log_to_file         = false,
                  output_length       = 100,
                  server_handle_static_files = true,
                  session_auto_start  = false,
                  suppress_output     = false,
                  websocket_server    = false,
                  flax_autoregister_webcomponents = true
                )

ENV["JULIA_REVISE"] = "auto"
