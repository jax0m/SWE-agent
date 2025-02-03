echo "----------------------------------- !!! Stage 02-1: Installing Python dependencies !!! -----------------------------------"
pip install --upgrade blinker
# added textual to: pip install --upgrade pip setuptools setuptools_scm wheel build unidiff pyyaml flask flask_cors flask_socketio meson ninja
pip install --upgrade pip setuptools setuptools_scm wheel build unidiff pyyaml flask flask_cors flask_socketio meson ninja textual
pip install --upgrade pycairo
pip cache purge
echo "----------------------------------- !!! Stage 02: Installed Python dependencies !!! -----------------------------------"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"