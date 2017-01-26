function [bank, stake] = ai_make_bet(bank, goal, probability_of_heads)
% value iteration
% v_k+1 = max_a(q?(s, a)) 
%   = max_a(E[R_t+1 + y * v_k(S_t+1)|S_t = s, A_t = a])
bank = bank - stake;
end