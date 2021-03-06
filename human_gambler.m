clear; clc;
% You bet a sum of money on a coin flip according to a policy. Your goal is
% to eventually win an ammount of money determined by the programmer. You 
% flip a coin whose probability of landing heads is also determined by the 
% programmer and you always bet on heads.

goal = 100;
reward = 0;
probability_of_heads = 40 / 100;

you_want_to_play = true;
while you_want_to_play
    bank = 10;
    
    while bank < 100 && bank > 0
        % Use all available information to determine the amount to gamble.
        % Bank will be reduced appropriately
        [bank, stake] = human_make_bet(bank, goal, probability_of_heads);
        
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
    you_want_to_play = input('Play again? (0 if not)\n');
end