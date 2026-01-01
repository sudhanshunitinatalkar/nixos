{ config, pkgs, ... }:

# docker run -it --rm --network=host   -v tb-node-data:/data   -v tb-node-logs:/var/log/thingsboard   -e SPRING_DATASOURCE_URL="jdbc:postgresql://localhost:5432/thingsboard"   -e SPRING_DATASOURCE_USERNAME=postgres   -e SPRING_DATASOURCE_PASSWORD=postgres   -e INSTALL_TB=true   -e LOAD_DEMO=true   sudhanshuatalkar/pbr-tb-node:latest
{
  virtualisation.docker.enable = true;

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {

      "pbr-tb-node" = {
        image = "sudhanshuatalkar/pbr-tb-node:latest"; 
        
        extraOptions = [ 
          "--network=host"
          "--memory=3g"
          # Logging options from your docker-compose
          "--log-opt=max-size=100m"
          "--log-opt=max-file=10"
        ];

        # Named volumes for data and logs
        volumes = [
          "tb-node-data:/data"
          "tb-node-logs:/var/log/thingsboard"
        ];
        
        environment = {
          # Network is host, so we connect to localhost
          SPRING_DATASOURCE_URL = "jdbc:postgresql://localhost:5432/thingsboard";
          SPRING_DATASOURCE_USERNAME = "postgres";
          SPRING_DATASOURCE_PASSWORD = "postgres";
          
          # Service ID from your compose file
          TB_SERVICE_ID = "pbr-tb-node";
          
          # Your specific optimizations
          TB_QUEUE_TYPE = "in-memory";
          DATABASE_ENTITIES_TYPE = "sql";
          JAVA_OPTS = "-Xms1G -Xmx2G"; 
        };
      };
    };
  };
}