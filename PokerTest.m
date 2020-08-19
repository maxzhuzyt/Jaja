function [result] = PokerTest(player1list, player2list, N,displayFlag)

results = zeros(length(player1list), length(player2list));

if ~iscell(player1list)
    player1list = { player1list };
end
if ~iscell(player2list)
    player2list = { player2list };
end

for i1 = 1:length(player1list)
    for i2 = 1:length(player2list)
        for i = 1:N
            clear global;
            results(i1,i2) = results(i1,i2)+RandomNumberTexasHoldem(player1list{i1}, player2list{i2});
        end
        results(i1,i2)=results(i1,i2)/N;
        if displayFlag==1
            disp([ func2str(player1list{i1}) ' won ' num2str((2-results(i1,i2))*100) '% against ' func2str(player2list{i2}) ]);
        end
    end
end

disp(' ');
p1res = mean(results, 2);
result=(2-p1res(i1))*100;
for i1 = 1:length(player1list)
    disp([ func2str(player1list{i1}) ' won ' num2str(result) '% as player 1' ]);
end

