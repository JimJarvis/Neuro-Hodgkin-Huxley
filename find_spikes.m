function [ num, spike ] = find_spikes( V )
%% Count the number of spikes in voltage

spike = [V(2:end-1) > V(1:end-2) & V(2:end-1) > V(3:end) & V(2:end-1) > 12];
spike = [logical(0) spike logical(0)];
num = sum(double(spike));

end

