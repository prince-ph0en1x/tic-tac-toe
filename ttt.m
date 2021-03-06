function ttt()
clear all
clc

ngam = 1;

for i = 1:ngam
    load X
    human = 1;
    n = size(X,1);
    move = zeros(1,10);
    img = ['-' '-' '-' '-' '-' '-' '-' '-' '-'];
    win = 0;
    for turn = 1:9
        if ((human == 1 && mod(turn,2)==0) || (human == 2 && mod(turn,2)==1) || (human == 0))
            freq = zeros(1,9);
            if (turn == 1)
                for j = 1:n                    
                    freq(X(j,turn)) = freq(X(j,turn)) + X(j,10);
                end
            else
                for j = 1:n
                    if(isequal(X(j,1:turn-1),move(1:turn-1)))
                        freq(X(j,turn)) = freq(X(j,turn)) + X(j,10)*(mod(turn,2)*2-1);
                    end
                end
            end
        
            %freq = freq + ones (1,9);
            freq = freq - min(freq) + 1;
            for j = 1:turn-1
                freq(move(j)) = 0;
            end
        
            % Roulette Wheel
            smf = sum(freq);
            freq = freq/smf;
            ch = 1;
            roult = rand;
            while (roult>0)
                roult = roult - freq(ch);
                ch = ch + 1;
            end
            move(turn) = ch - 1;
            if (human~=0)
                disp(['AI Move   : ' num2str(move(turn))]);
            end
        elseif ((human == 1 && mod(turn,2)==1) || (human == 2 && mod(turn,2)==0))
            htry = 1;
            while (htry == 1)
                move(turn) = input('Your Move : ');
                htry = 0;
                for j = 1:turn-1
                    if (move(turn) == move(j))
                        disp('Invalid Move!');
                        htry = 1;
                        break;
                    end
                end
            end                
        end
        % disp(move);
        
        for k = 1:9
            if(mod(k,2)==0 && move(k)~=0) 
                img(move(k)) = 'O';
            elseif(move(k)~=0) 
                img(move(k)) = 'X' ;
            %else
            %    img(k) = '-';
            end
        end
        disp(img(1:3))
        disp(img(4:6))
        disp(img(7:9))
        
        if(win == 0)
            % Evaluate which player wins
            p1 = move(:,1:2:end);
            p2 = move(:,2:2:end);
            if ((~isempty(find(p1==1)) && ~isempty(find(p1==2)) && ~isempty(find(p1==3))) || (~isempty(find(p1==4)) && ~isempty(find(p1==5)) && ~isempty(find(p1==6))) || (~isempty(find(p1==7)) && ~isempty(find(p1==8)) && ~isempty(find(p1==9))) ||  (~isempty(find(p1==1)) && ~isempty(find(p1==4)) && ~isempty(find(p1==7))) || (~isempty(find(p1==2)) && ~isempty(find(p1==5)) && ~isempty(find(p1==8))) || (~isempty(find(p1==3)) && ~isempty(find(p1==6)) && ~isempty(find(p1==9))) || (~isempty(find(p1==1)) && ~isempty(find(p1==5)) && ~isempty(find(p1==9))) || (~isempty(find(p1==3)) && ~isempty(find(p1==5)) && ~isempty(find(p1==7))))
                move(1,10) = 1;
                disp('Player 1 won');
                win = 1;
            elseif ((~isempty(find(p2==1)) && ~isempty(find(p2==2)) && ~isempty(find(p2==3))) || (~isempty(find(p2==4)) && ~isempty(find(p2==5)) && ~isempty(find(p2==6))) || (~isempty(find(p2==7)) && ~isempty(find(p2==8)) && ~isempty(find(p2==9))) ||  (~isempty(find(p2==1)) && ~isempty(find(p2==4)) && ~isempty(find(p2==7))) || (~isempty(find(p2==2)) && ~isempty(find(p2==5)) && ~isempty(find(p2==8))) || (~isempty(find(p2==3)) && ~isempty(find(p2==6)) && ~isempty(find(p2==9))) || (~isempty(find(p2==1)) && ~isempty(find(p2==5)) && ~isempty(find(p2==9))) || (~isempty(find(p2==3)) && ~isempty(find(p2==5)) && ~isempty(find(p2==7))))
                move(1,10) = -1;
                disp('Player 2 won');
                win = 1;
            else
                move(1,10) = 0;
            end
        end
    
    end
    
    if(move(1,10) == 0)
        disp('Draw');
    end
       
    X = [X;move];
    save X.mat;
end
end