function bet = John1(command, card, myscore, oppscore, minbet, bet)

SMALL_BLIND = 1;
BIG_BLIND = 2;
BET = 3;
WIN = 4;
LOSE = 5;

global john1card john1role;

switch command
    case SMALL_BLIND
    % I am the Small Blind. card contains my card
        john1card = card;
        john1role = SMALL_BLIND;
        bet = minbet;
    case BIG_BLIND
    % I am the Big Blind. card contains my card
        john1card = card;
        john1role = BIG_BLIND;
        bet = 2*minbet;
    case BET
    % betting rounds. bet contains current bid
        bet = ceil(bet/minbet)*minbet;
        if (bet > (10.0 * john1card * minbet))
            if (strcmp(john1role,BIG_BLIND)&&bet == (2 * minbet))
            else
                bet = 0;
            end
        elseif (bet > (5.0 * john1card * minbet))
        elseif (bet == oppscore)
        else
            bet = bet + minbet;
        end
    otherwise
        bet = 0;
end