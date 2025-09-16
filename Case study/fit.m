function It_Q_sim = fit(theta,d,Q_test,Date_index_test)
% parameter estimation
% input parameter:
% time_train: the sample time
% level_diff_train: inventory level changes
% level_train: inventory level
% output parameter:
% pars: [theta,alpha,beta]

It_Q_sim={};
cell_length=length(Q_test);
for i = 1:cell_length
    time=Date_index_test{i};
    Q=Q_test{i};
    c=Q+d/theta;
    It=c*exp(-theta*time)-d/theta;
    It_Q_sim{i}=It;
end


end

