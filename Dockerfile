FROM python:latest
# Use an official Ubuntu base image
# FROM ubuntu:22.04

# Set environment variables
# ENV DEBIAN_FRONTEND=noninteractive

# Create logging directory
RUN mkdir -p ~/buildlogs

# Stage 01 - Update installed packages
COPY ./Dockerfile_buildscripts/01_updatebasepackages.sh /usr/local/bin/01_updatebasepackages.sh
RUN chmod +x /usr/local/bin/01_updatebasepackages.sh
RUN /usr/local/bin/01_updatebasepackages.sh | tee ~/buildlogs/01_updatebasepackages.log

# Stage 01.5 - Install docker
RUN echo "Installing docker" && \
    curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh get-docker.sh  | tee ~/buildlogs/01.5_installDocker.log && \
    echo "Completed - Installed docker"

# Add a user named 'sweagent'
RUN useradd -m -s /bin/bash sweagent

# Create working directory and assign ownership to the user
RUN mkdir -p /app && \
    chown -R sweagent:users /app

# Move into working directory
WORKDIR /app

# RUN python -m venv /app

# Stage 02 - Setup python environment and install python dependencies
#COPY ./Dockerfile_buildscripts/02_pythonDependencies.sh /usr/local/bin/02_pythonDependencies.sh
#RUN chmod +x /usr/local/bin/02_pythonDependencies.sh
#RUN /usr/local/bin/02_pythonDependencies.sh | tee ~/buildlogs/02_pythonDependencies.log
# Updating the pip update and throwing in a call for legacy-cgi base on https://github.com/jax0m/SWE-agent/issues/3#issuecomment-2632057310
RUN pip install --upgrade pip legacy-cgi | tee ~/buildlogs/02_pythonDependencies.log
# RUN pip install --upgrade pip | tee ~/buildlogs/02_pythonDependencies.log

# Install docker CLI and pull in/install repo for swe-agent
# RUN git clone https://github.com/jax0m/SWE-agent .
COPY / /app

# build app
RUN pip install . | tee ~/buildlogs/03_buildsweagent.log

# temporary patch related to issue #1 https://github.com/jax0m/SWE-agent/issues/1 - Copy the directories that get called by relative path that arent included in the compiled app
RUN cp -r assets/ /usr/local/lib/python3.13/site-packages/assets && \
    cp -r config/ /usr/local/lib/python3.13/site-packages/config && \
    cp -r docs/ /usr/local/lib/python3.13/site-packages/docs && \
    cp -r scripts/ /usr/local/lib/python3.13/site-packages/scripts && \
    cp -r tests/ /usr/local/lib/python3.13/site-packages/tests && \
    cp -r tools/ /usr/local/lib/python3.13/site-packages/tools && \
    cp -r trajectories/ /usr/local/lib/python3.13/site-packages/trajectories





# -------------------------------------------------------
# Issue: 
    # While install does complete there are unresolved issues with placement of
    # some of the folders/other scripts/configs that cause errors on runs without
    # doing some modifications. Was able to temporarily (not cleanly) corret for the moment
    # see "temp solution"

    # TBD code that I had intended to keep active to:
        # run install
        # install frontend
        # switch to named user (then run things ;P )
        # Code:
            # RUN pip install .
            # RUN cd sweagent/frontend && npm install
            # Switch to the 'sweagent'
            # USER sweagent


    # Error when attempting to run "sweagent --help" returns:
        #Traceback (most recent call last):
        #    File "/usr/local/bin/sweagent", line 5, in <module>
        #      from sweagent.run.run import main
        #    File "/usr/local/lib/python3.10/dist-packages/sweagent/__init__.py", line 30, in <module>
        #      assert CONFIG_DIR.is_dir(), CONFIG_DIR
        #  AssertionError: /usr/local/lib/python3.10/dist-packages/config

    # Temp fix (ran in "/app", essentially the scripts appear to be calling to parents that dont exist as they are outside of sweagent folder):
        # cp -r assets/ /usr/local/lib/python3.10/dist-packages/assets # Probably not needed was just being lazy
        # cp -r config/ /usr/local/lib/python3.10/dist-packages/config # Definitely needed
        # cp -r docs/ /usr/local/lib/python3.10/dist-packages/docs # Probably not needed was just being lazy
        # cp -r scripts/ /usr/local/lib/python3.10/dist-packages/scripts
        # cp -r tests/ /usr/local/lib/python3.10/dist-packages/tests
        # cp -r tools/ /usr/local/lib/python3.10/dist-packages/tools
        # cp -r trajectories/ /usr/local/lib/python3.10/dist-packages/trajectories

CMD [ "echo All Done" ]