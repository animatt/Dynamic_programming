clear; clc;
% You bet a sum of money on a coin flip according to a policy. Your goal is
% to eventually win a certain amount of money and learn a policy maximizing
% the probability of doing this. You flip a coin whose probability of
% landing heads is not necessarily 50% and you may only bet on heads.

goal = 100;
starting_bank = 10;
probability_of_heads = 40 / 100;

V = zeros(goal - 1, 1);
A = (1 : 50)';
S = (1 : goal - 1)';

pssa = [probability_of_heads, 1 - probability_of_heads]'; % p(s'|s,a)

figure; hold on

% value iteration
learner_is_converging = true;
count = 0;
while learner_is_converging
    for s = S'
        v = [0; V; 0];
        A_s = A(1 : min(s, goal - s));
        r = zeros(2, length(A));
        r(1, A_s(end)) = s + A_s(end) == goal;
        
        % v_k+1 = max_a(E[R_t+1 + y v_k(S_t+1)|S_t = s, A_t = a])
        %  = max_a(?_r,s' p(s',r|s,a)(r + y v(s')))
        %  = max_a(?_r,s' p(r|s',s,a)p(s'|s,a)(r + y v(s')))
        %  = max_a(?_s' 1{s' == 100}p(s'|s,a)(r + y v(s')))
        
        for a = A_s'
            s_next = [s + a; s - a];
            V(s) = max(pssa' * (r + v(s_next * ones(1, length(r)) + 1)));
        end
    end
    if count > 50
        learner_is_converging = false;
    end
    plot(S, V)
    count = count + 1;
end

hold off

xlabel('state s')
ylabel('state value function v(s)')

figure; hold on
policy = zeros(goal - 1, 1);
for s = S'
    v = [0; V; 0];
    A_s = A(1 : min(s, goal - s));
    r = zeros(length(A_s), 2);
    r(end, 1) = s + A_s(end) == goal
    
    for a = A_s'
        s_next = [s + a; s - a];
%         [~, policy(s)] = max(
    end
     % what goes here? does the value iteration algorithm used earlier actually make sense? is there a better way?
end

% bank = starting_bank;
% 
% while bank < 100 && bank > 0
%     % Use all available information to determine the amount to gamble.
%     % Bank will be reduced appropriately
%     [bank, stake] = ai_make_bet(bank, goal, probability_of_heads);
%     
%     % Return true if coin lands heads
%     heads = flip_coin(probability_of_heads);
%     
%     % Increase bank if you won
%     bank = bank + 2 * heads * stake;
% end
% 
% if bank >= 100
%     fprintf('You win\n')
%     reward = reward + 1;
% else
%     fprintf('You lose\n')
% end
