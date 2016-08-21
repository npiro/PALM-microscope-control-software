% Connects to and Initializes the mirror.

addpath('./lib');

connectToMirror()

ip=calllib('mirrorDriverC', 'getServerIPAddress')