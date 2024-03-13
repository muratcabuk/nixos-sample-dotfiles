# https://nixos.wiki/wiki/PostgreSQL
{ lib, config, pkgs, ...}:
{ 
  
  options = {
      postgres.database_name = lib.mkOption {
        type = lib.types.str;
        description = "database name"
        default = null;
      };


      postgres.username = lib.mkOption {
        type = lib.types.str;
        description = "db username"
        default = null;
      };

      postgres.password = lib.mkOption {
        type = lib.types.str;
        description = "db password"
        default = null;
      };

    };
  
config = lib.mkMerge [ {
                          postgres.username = "admin";
                          postgres.password = "Abc123";
                          postgres.database_name = "mydatabase";
                        }

                        # eğer nginx enable ise postgres de çalışsın
                        (lib.mkIf config.services.nginx {

                                config.services.postgresql = {
                                    enable = true;
                                    ensureDatabases = [ config.postgres.database_name ];
                                    enableTCPIP = true;
  
                                    port = 5432;
  
                                      initialScript = pkgs.writeText "backend-initScript" ''
                                            CREATE ROLE ${config.postgres.username} WITH LOGIN PASSWORD '${config.postgres.password}' CREATEDB;
                                            CREATE DATABASE ${config.postgres.database_name};
                                            GRANT ALL PRIVILEGES ON DATABASE ${config.postgres.database_name} TO ${config.postgres.username};
                                            '';
                                      };};
                        )
                    ];

}