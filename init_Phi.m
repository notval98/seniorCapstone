% init_Phi.m - initialize basis functions matrix
%
% function Phi = init_Phi(N,M)

function Phi = init_Phi(N,M)

Phi=randn(N,M);
Phi=Phi*diag(1./sqrt(sum(Phi.*Phi)));
