function AndorGetLastImage(im,totalpixels)

ret=calllib('ATMCD32D','GetMostRecentImage',im,totalpixels);