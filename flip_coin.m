function outcome = flip_coin(heads_probability)
outcome = rand;
if outcome >= heads_probability
    outcome = true;
else
    outcome = false;
end
end