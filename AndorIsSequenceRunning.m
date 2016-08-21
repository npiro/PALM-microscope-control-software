function [SeqRunning] = AndorIsSequenceRunning

pStat = libpointer('int32Ptr',0);
calllib('ATMCD32D','GetStatus',pStat);
Stat = pStat.Value;
if (Stat == 20072) % DRV_ACQUIRING
    SeqRunning = true;
else
    SeqRunning = false;
end