template {
    source = "/etc/consul-template/templates/mysqldump.ctmpl"
    destination = "/etc/mysql/conf.d/mysqldump.cnf"
  
    # This is the optional command to run when the template is rendered. The
    # command will only run if the resulting template changes. The command must
    # return within 30s (configurable), and it must have a successful exit code.
    # Consul Template is not a replacement for a process monitor or init system.
    # command = "cat /tmp/secrets.txt"
  
    # This is the maximum amount of time to wait for the optional command to
    # return. Default is 30s.
    command_timeout = "60s"
  
    # Exit with an error when accessing a struct or map field/key that does not
    # exist. The default behavior will print "<no value>" when accessing a field
    # that does not exist. It is highly recommended you set this to "true" when
    # retrieving secrets from Vault.
    error_on_missing_key = false
  
    # This is the permission to render the file. If this option is left
    # unspecified, Consul Template will attempt to match the permissions of the
    # file that already exists at the destination path. If no file exists at that
    # path, the permissions are 0644.
    perms = 0600
  
    # This option backs up the previously rendered template at the destination
    # path before writing a new one. It keeps exactly one backup. This option is
    # useful for preventing accidental changes to the data without having a
    # rollback strategy.
    backup = true
  
    # This is the `minimum(:maximum)` to wait before rendering a new template to
    # disk and triggering a command, separated by a colon (`:`). If the optional
    # maximum value is omitted, it is assumed to be 4x the required minimum value.
    # This is a numeric time with a unit suffix ("5s"). There is no default value.
    # The wait value for a template takes precedence over any globally-configured
    # wait.
    wait {
      min = "2s"
      max = "10s"
    }
  }