function output = humaninput(question, error_message, bank)
valid_answer = false;
while ~valid_answer
    x = input(question);
    if bank - x >= 0
        output = x;
        valid_answer = true;
    else
        fprintf(error_message)
    end
end