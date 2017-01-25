clear; clc;
% You bet a sum of money on a coin flip according to a policy. Your goal is
% to eventually win a certain amount of money and learn a policy maximizing
% the probability of doing this. You flip a coin whose probability of 
% landing heads is not necessarily 50% and you may only bet on heads.

goal = 100;
reward = 0;
starting_bank = 10;
probability_of_heads = 40 / 100;

learner_is_converging = true;
while learner_is_converging
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
    learner_is_converging;
end