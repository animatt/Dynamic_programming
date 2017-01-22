function [bank, stake] = human_make_bet(bank, goal, probability_of_heads)
% logic to determine stake
question = sprintf(['You currently have %d in the bank. How much ' ...
    'are you willing to gamble?\n'], bank);
error_message = '\nYou don''t have enough money.\n';

stake = humaninput(question, error_message, bank);
bank = bank - stake;
end