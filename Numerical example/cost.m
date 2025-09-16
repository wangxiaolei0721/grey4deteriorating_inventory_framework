function f=cost(d,theta,c,h,K,T)
% objective function
% cost function
% T is decision variable

cthetah=c*theta+h;
dthetaT=d./(theta^2*T);
f= K./T + cthetah.*(dthetaT.*(exp(theta*T)-1)-d/theta);


end