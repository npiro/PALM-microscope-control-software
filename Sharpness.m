function [Sharpness] = Sharpness(subim)

Sharpness = sum(subim(:).^2); % Image sharpness.