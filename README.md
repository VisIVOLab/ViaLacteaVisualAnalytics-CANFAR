# ViaLacteaVisualAnalytics-CANFAR
ViaLacteaVisualAnalytics Docker Image for the CANFAR Science Platform, based on [opencadc/science-containers](https://github.com/opencadc/science-containers).

The CANFAR Science Platform supports various types of containers: session, software, and legacy desktop application:

- Session are containers launched as native browser interactive applications (i.e. HTML5/Websocket).
- Software are containers launched with any kind of executable, installed with custom software stack.
- Legacy desktop application are containers launched and viewed specifically through a desktop session.

VLVA's container falls into the Legacy desktop application type.

These containers must meet a minimal set of requirements and expectations for execution in skaha:

- Containers must be based on a standard Linux x86_84 distribution.
- Containers must contain an SSSD client and have ACL capabilities if one want to interact with the arc storage.
- The default executable is xterm, so it must be installed.

## Software container initialization
The CMD and EXECUTABLE directives in a CANFAR container Dockerfile will be ignored on startup. Instead, bash within an xterm will run.
A script called init.sh in the root directory of /skaha can be used to initialize the container at runtime.

Another option is for containers to provide a file called /skaha/startup.sh.
If it exists, it is invoked with a single parameter, which is the command that startup.sh must execute to run on the platform.

Containers should use startup.sh when the environment needs to be made available to the context of the application.

## SSSD and ACL
In order for Linux group id (gid) names to be resolved, the container must have an SSSD client and ACL tools installed, as well as an nsswitch.conf file.

The /etc/nsswitch.conf file must include the sss module in the passwd, shadow, and group entries.
