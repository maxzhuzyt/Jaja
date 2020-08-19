function bet = me_play(command, card, myscore, oppscore, minbet, bet)
SMALL_BLIND = 1;
BIG_BLIND = 2;
BET = 3;
WIN = 4;
LOSE = 5;

switch command
    case SMALL_BLIND
    % I am the Small Blind. card contains my card
        
        disp(' ');
        disp(' ');
        disp('-------- New hand --------');
        disp(['Your score is ' num2str(myscore)]);
        disp(['Your opponent''s score is ' num2str(oppscore)]);
        disp(' ');
        disp('You are the small blind');
        disp(['Your card is ' num2str(card)]);
        
        bet = minbet;
    case BIG_BLIND
    % I am the Big Blind. card contains my card
    
        disp(' ');
        disp(' ');
        disp('-------- New hand --------');
        disp(['Your score is ' num2str(myscore)]);
        disp(['Your opponent''s score is ' num2str(oppscore)]);
        disp(' ');
        disp('You are the big blind');
        disp(['Your card is ' num2str(card)]);
        
        bet = 2*minbet;
    case BET
    % betting rounds. bet contains current bid
        
        disp(['Your opponent bet ' num2str(bet)]);
        disp(['The minimum bet is ' num2str(minbet)]);
        bet = input('What will you bet as the total in the pot? ');
    case WIN
    % I won the hand. bet contains how much I won
        disp('You won!');
        if ~isempty(card)
            % by call. card contains opponent's card
            
            disp(['Your opponent''s card was ' num2str(card)]);
        else
            % opponent folded. I don't get to see opponent's card
            disp('Your opponent folded');
        end
    case LOSE
    % I lost the hand. bet contains how much I lost
        disp('You lost :(');
        if ~isempty(card)
            disp(['Your opponent''s card was ' num2str(card)]);
        else
            disp('You folded, so opponent''s card not revealed');
        end
end