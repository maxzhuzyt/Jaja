function winPlayer = RandomNumberTexasHoldem(p1, p2)

playerScore1 = 100;
playerScore2 = 100;
SmallBlind = rand>0.5;
count = 1;
minbet = 1;

while (playerScore1 > 0) && (playerScore2 > 0)
    minscore = min(playerScore1, playerScore2);
    
    cards = rand(1,2); % draw cards

    if SmallBlind
        p1(2, cards(1), playerScore1, playerScore2, minbet, minbet);
        p2(1, cards(2), playerScore2, playerScore1, minbet, 0);
    else
        p1(1, cards(1), playerScore1, playerScore2, minbet, 0);
        p2(2, cards(2), playerScore2, playerScore1, minbet, minbet);
    end

    oldBetPot = min(minbet, minscore);
    betPot = min(2*minbet, minscore);

    turn = SmallBlind;

    firstbet = 1;
    while 1
        if turn
            bet = p2(3, cards(2), playerScore2, playerScore1, minbet, betPot);
        else
            bet = p1(3, cards(1), playerScore1, playerScore2, minbet, betPot);
        end

        if (bitand(bet,minbet-1) ~= 0) && bet < minscore && (bet ~= betPot)
            if turn
                error(['Player ' func2str(p2) ...
                    ' did not bet a multiple of the minimum bet']);
            else
                error(['Player ' func2str(p1) ...
                    ' did not bet a multiple of the minimum bet']);
            end
        end

        bet = min(bet, minscore);
        if (bet < betPot)
        % fold
            cards = [];
            betPot = oldBetPot;
            turn = ~turn;
            break;
        elseif (bet == betPot) && ~firstbet
        % call
            betPot = bet;

            turn = cards(2) > cards(1);
            break;
        else
        % raise (or call on small-blind's first bet)
            firstbet = 0;

            oldBetPot = betPot;
            betPot = bet;
            turn = ~turn;
        end
    end

    if turn
        playerScore1 = playerScore1 - betPot;
        playerScore2 = playerScore2 + betPot;
        if isempty(cards)
            p1(5, [], playerScore1, playerScore2, minbet, betPot);
            p2(4, [], playerScore2, playerScore1, minbet, betPot);
        else
            p1(5, cards(2), playerScore1, playerScore2, minbet, betPot);
            p2(4, cards(1), playerScore2, playerScore1, minbet, betPot);
        end
    else
        playerScore1 = playerScore1 + betPot;
        playerScore2 = playerScore2 - betPot;
        if isempty(cards)
            p1(4, [], playerScore1, playerScore2, minbet, betPot);
            p2(5, [], playerScore2, playerScore1, minbet, betPot);
        else
            p1(4, cards(2), playerScore1, playerScore2, minbet, betPot);
            p2(5, cards(1), playerScore2, playerScore1, minbet, betPot);
        end
    end

    SmallBlind = ~SmallBlind;
    count = count + 1;
    if count == 100
        minbet = 2*minbet;
        count = 0;
    end
end

winPlayer = (playerScore1==0)+1;