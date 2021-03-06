function mybet = PokerPlayer(command, card, myscore, oppscore, minbet, oppbet)

SMALL_BLIND = 1;
BIG_BLIND = 2;
BET = 3;
WIN = 4;
LOSE = 5;

global mycard myrole;
global blufferdetected;
global blufferdetectedd;

global numhands;
global oppraisesidx;
global oppRaises;
global iraised;
global oppraised;
global myhist;
global lastbet;


if isempty(myhist)
    myhist = zeros(3,100);
    numhands = 1;
    oppraisesidx = 0;
    oppRaises = zeros(2,100);
    oppraised = false;
    iraised = false;
    blufferdetected = 0;
    blufferdetectedd = 0;
end

switch command
    case SMALL_BLIND
    % I am the Small Blind. card contains my card
        mycard = card;
        myrole = SMALL_BLIND;
        mybet = minbet;
        iraised = false;
        lastbet = mybet;
    case BIG_BLIND
    % I am the Big Blind. card contains my card
        mycard = card;
        myrole = BIG_BLIND;
        mybet = 2*minbet;
        iraised = false;
        lastbet = mybet;
    case BET
    % betting rounds. bet contains current bid
        oppbet = ceil(oppbet/minbet)*minbet;
        blufferdetectedd = oppraisesidx/numhands;
        p = (oppbet - lastbet)/(2*oppbet);
        if (~iraised && oppbet > 2 * minbet)
            
            oppraised = true;
        end
        
        if not (blufferdetected > 8 | blufferdetectedd > 2/3)
        if (oppbet > (10.0 * mycard * minbet))
            if (strcmp(myrole,BIG_BLIND)&&~iraised)
                mybet = oppbet;
            else
                mybet = 0;
            end
        elseif (oppbet > (5.0 * mycard * minbet))
            mybet = oppbet;
        elseif (oppbet == oppscore)
            mybet = oppbet;
            
        else
            if (p < 0.23)
                mybet = oppbet;
            end
            mybet = oppbet + minbet;
            iraised = true;
            end
        else
        if (card > .8)
               mybet = ceil(oppbet/minbet)*minbet;
           else
               mybet = 0;
        end
        end
        %if (mycard > 0.90)
            %mybet = oppbet + minbet * ceil(5*(mycard-0.9));
            if (mycard > 0.95)
                mybet = ceil(min([myscore, oppscore])/minbet)*minbet;
            end
        %end
        
        lastbet = mybet;
    case WIN
        myhist(1,numhands) = 1;
        if oppraised
            oppraisesidx = oppraisesidx + 1;
            
        end
        if ~isempty(card)    
            myhist(2,numhands) = card;
            if oppraised
            myhist(3,numhands) = 1;
            oppRaises(1,oppraisesidx)=card;
            oppRaises(2,oppraisesidx)=oppbet;
      
            end
        else %I folds
            myhist(2,numhands) = oppbet;
        end
        numhands = numhands + 1;
        oppraised = false;
        iraised = false;
    case LOSE
        myhist(1,numhands) = ~1;
        if oppraised
            oppraisesidx = oppraisesidx + 1;
        end
        if ~isempty(card)
            myhist(2,numhands) = card;
            if oppraised
            oppRaises(1,oppraisesidx)=card;
            oppRaises(2,oppraisesidx)=oppbet;
            if (card < 0.5)
                blufferdetected = blufferdetected + 1;
            end
            end
        else % opp folds
        end
        numhands = numhands + 1;
        oppraised = false;
        iraised = false;
        
end