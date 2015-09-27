function setaxis(t, vals)
  %% set axis to appropriate range
  mn = min(vals);
  mx = max(vals);
  rang = mx - mn;
  axis([min(t), max(t), mn - .1 * rang, mx + .1 * rang]);
end
