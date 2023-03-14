output "paths" {
  description = "The reachability analyzer paths for example."
  value = {
    success = module.reachability_analyzer_path__success
    fail    = module.reachability_analyzer_path__fail
  }
}
