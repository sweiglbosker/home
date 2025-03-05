# wip, need to look into nixpkgs.lib.extend
{
  # create runit backend specific turnstile service
  mkExecutableService = 
  {
    name,
    command,
    log,
  }:
  let 
    sh = s: "#!/bin/sh\n${s}"
  in
  {
    "${name}" = {
      run = sh ''exec chpst -e "$TURNSTILE_ENV_DIR" ${command}'';
      log = lib.sh ''exec vlogger -t ${name}-$(id -u) -p daemon''; 
      # creating syslog but tagging with uid, might want to change this to local logging? 
      # user cant read unless in socklog group and using socklog
    };
  }
}
