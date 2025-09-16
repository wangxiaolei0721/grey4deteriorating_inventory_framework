function f=cost_appro(d,theta,c,h,K,T)
% objective function
% cost function
% T is decision variable

cthetah=c*theta+h;
f= K./T + d.*cthetah.*T/2;


end