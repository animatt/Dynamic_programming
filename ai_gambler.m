clear; clc;
% You bet a sum of money on a coin flip according to a policy. Your goal is
% to eventually win a certain amount of money and learn a policy maximizing
% the probability of doing this. You flip a coin whose probability of
% landing heads is not necessarily 50% and you may only bet on heads.

goal = 100;
starting_bank = 10;
probability_of_heads = 40 / 100;

V = zeros(goal, 1);
A = (1 : 50)';
R = [A, -A]';
S = (1 : goal - 1)';

gamma = 0.9;

psrsa = [probability_of_heads, 1 - probability_of_heads]'; % p(s',r|s,a)

% pol = [1 : 50, 49: -1: 1]';

% value iteration
learner_is_converging = true;
count = 0;
while learner_is_converging
    for ii = S
        jj = ii + 1; % index into S+
        
        v = [0; V; 0]';
        v_top = v(jj + 1 : min(2 * jj - 1, goal - jj));
        v_bot = v(jj - 1 : -1 : max(1, 2 * jj - goal));
        v = [v_top'; v_bot']
        
        r = R(:, 1 : min(ii, goal - ii))
        % max_a(E[R_t+1 + y * v_k(S_t+1)|S_t = s, A_t = a])
        % max_a(?_r,s' p(s',r|s,a)(r + y v(s')))
        V(ii) = max(psrsa' * (r + gamma * v));
        
%         psrsa * (R(ii, 1) + gamma * v) ... 
%             + (1 - psrsa) * (R(ii, 2) + gamma * v);
    end
    V;
    if count > 3
        learner_is_converging = false;
    end
    count = count + 1;
end



bank = starting_bank;

while bank < 100 && bank > 0
    % Use all available information to determine the amount to gamble.
    % Bank will be reduced appropriately
    [bank, stake] = ai_make_bet(bank, goal, probability_of_heads);
    
    % Return true if coin lands heads
    heads = flip_coin(probability_of_heads);
    
    % Increase bank if you won
    bank = bank + 2 * heads * stake;
end

if bank >= 100
    fprintf('You win\n')
    reward = reward + 1;
else
    fprintf('You lose\n')
end