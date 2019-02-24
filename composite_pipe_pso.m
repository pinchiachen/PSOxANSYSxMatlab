% Ver. Excitation & Flashback & Memory point & 改end_count為激發前比較記憶點tol=0.5
%      激發後刪除pbest與gbest
clc
clear
close all
rng shuffle
LB_E2=10^9*[5 5 5 5 5];       % lower bounds of E2
UB_E2=10^9*[13 13 13 13 13];  % upper bounds of E2
% pso parameters values
m=5;        % number of variables
n=50;       % population size
wmax=0.9;   % inertia weight
wmin=0.4;   % inertia weight
c1=2;       % acceleration factor
c2=2;       % acceleration factor
% ANSYS parameters values
count_f=8;  % 要使用前 count_f 個頻率來反算
expf=[172.55 175.46 293.68 486.91 495.06 509.42 593.23 657.63];   % 複材圓管前 count_f 個共振頻率
% pso main program----------------------------------------------------start
maxite=50;    % set maximum number of iteration
maxrun=5;     % set maximum number of runs need to be

tic
for run=1:maxrun
    clear gbest_result_E2;
    run
    % pso initialization--------------------------------------------------start
    
    for i=1:n
        for j=1:m
            E2(i,j)=LB_E2(j)+rand()*(UB_E2(j)-LB_E2(j));
        end
    end
    
    
    % 寫APDL，呼叫，讀取，計算目標函數
    for i=1:n
        E2A=E2(i,1);
        E2B=E2(i,2);
        E2C=E2(i,3);
        E2D=E2(i,4);
        E2E=E2(i,5);
        fid=fopen('D:\study\ansys\psotoapdl.log','w');
        fprintf(fid,'/BATCH \r\n');
        fprintf(fid,'/PREP7 \r\n');
        fprintf(fid,'ET,1,SHELL281 \r\n');
        fprintf(fid,'KEYOPT,1,1,0 \r\n');
        fprintf(fid,'KEYOPT,1,8,0 \r\n');
        fprintf(fid,'KEYOPT,1,9,0 \r\n');
        
        % 開始建五種材料參數
        
        % 第一種材料參數
        fprintf(fid,'MPTEMP,,,,,,,, \r\n');
        fprintf(fid,'MPTEMP,1,0 \r\n');
        fprintf(fid,'MPDATA,EX,1,,131E9 \r\n');
        fprintf(fid,'MPDATA,EY,1,,%d \r\n',E2A);
        fprintf(fid,'MPDATA,EZ,1,,%d \r\n',E2A);
        fprintf(fid,'MPDATA,PRXY,1,,0.28 \r\n');
        fprintf(fid,'MPDATA,PRYZ,1,,0.024 \r\n');
        fprintf(fid,'MPDATA,PRXZ,1,,0.024 \r\n');
        fprintf(fid,'MPDATA,GXY,1,,6.55E9 \r\n');
        fprintf(fid,'MPDATA,GYZ,1,,6.55E9 \r\n');
        fprintf(fid,'MPDATA,GXZ,1,,6.55E9 \r\n');
        fprintf(fid,'MPTEMP,,,,,,,, \r\n');
        fprintf(fid,'MPTEMP,1,0 \r\n');
        fprintf(fid,'MPDATA,DENS,1,,1600 \r\n');
        
        % 第二種材料參數
        fprintf(fid,'MPTEMP,,,,,,,, \r\n');
        fprintf(fid,'MPTEMP,1,0 \r\n');
        fprintf(fid,'MPDATA,EX,2,,131E9 \r\n');
        fprintf(fid,'MPDATA,EY,2,,%d \r\n',E2B);
        fprintf(fid,'MPDATA,EZ,2,,%d \r\n',E2B);
        fprintf(fid,'MPDATA,PRXY,2,,0.28 \r\n');
        fprintf(fid,'MPDATA,PRYZ,2,,0.024 \r\n');
        fprintf(fid,'MPDATA,PRXZ,2,,0.024 \r\n');
        fprintf(fid,'MPDATA,GXY,2,,6.55E9 \r\n');
        fprintf(fid,'MPDATA,GYZ,2,,6.55E9 \r\n');
        fprintf(fid,'MPDATA,GXZ,2,,6.55E9 \r\n');
        fprintf(fid,'MPTEMP,,,,,,,, \r\n');
        fprintf(fid,'MPTEMP,1,0 \r\n');
        fprintf(fid,'MPDATA,DENS,2,,1600 \r\n');
        
        % 第三種材料參數
        fprintf(fid,'MPTEMP,,,,,,,, \r\n');
        fprintf(fid,'MPTEMP,1,0 \r\n');
        fprintf(fid,'MPDATA,EX,3,,131E9 \r\n');
        fprintf(fid,'MPDATA,EY,3,,%d \r\n',E2C);
        fprintf(fid,'MPDATA,EZ,3,,%d \r\n',E2C);
        fprintf(fid,'MPDATA,PRXY,3,,0.28 \r\n');
        fprintf(fid,'MPDATA,PRYZ,3,,0.024 \r\n');
        fprintf(fid,'MPDATA,PRXZ,3,,0.024 \r\n');
        fprintf(fid,'MPDATA,GXY,3,,6.55E9 \r\n');
        fprintf(fid,'MPDATA,GYZ,3,,6.55E9 \r\n');
        fprintf(fid,'MPDATA,GXZ,3,,6.55E9 \r\n');
        fprintf(fid,'MPTEMP,,,,,,,, \r\n');
        fprintf(fid,'MPTEMP,1,0 \r\n');
        fprintf(fid,'MPDATA,DENS,3,,1600 \r\n');
        
        % 第四種材料參數
        fprintf(fid,'MPTEMP,,,,,,,, \r\n');
        fprintf(fid,'MPTEMP,1,0 \r\n');
        fprintf(fid,'MPDATA,EX,4,,131E9 \r\n');
        fprintf(fid,'MPDATA,EY,4,,%d \r\n',E2D);
        fprintf(fid,'MPDATA,EZ,4,,%d \r\n',E2D);
        fprintf(fid,'MPDATA,PRXY,4,,0.28 \r\n');
        fprintf(fid,'MPDATA,PRYZ,4,,0.024 \r\n');
        fprintf(fid,'MPDATA,PRXZ,4,,0.024 \r\n');
        fprintf(fid,'MPDATA,GXY,4,,6.55E9 \r\n');
        fprintf(fid,'MPDATA,GYZ,4,,6.55E9 \r\n');
        fprintf(fid,'MPDATA,GXZ,4,,6.55E9 \r\n');
        fprintf(fid,'MPTEMP,,,,,,,, \r\n');
        fprintf(fid,'MPTEMP,1,0 \r\n');
        fprintf(fid,'MPDATA,DENS,4,,1600 \r\n');
        
        % 第五種材料參數
        fprintf(fid,'MPTEMP,,,,,,,, \r\n');
        fprintf(fid,'MPTEMP,1,0 \r\n');
        fprintf(fid,'MPDATA,EX,5,,131E9 \r\n');
        fprintf(fid,'MPDATA,EY,5,,%d \r\n',E2E);
        fprintf(fid,'MPDATA,EZ,5,,%d \r\n',E2E);
        fprintf(fid,'MPDATA,PRXY,5,,0.28 \r\n');
        fprintf(fid,'MPDATA,PRYZ,5,,0.024 \r\n');
        fprintf(fid,'MPDATA,PRXZ,5,,0.024 \r\n');
        fprintf(fid,'MPDATA,GXY,5,,6.55E9 \r\n');
        fprintf(fid,'MPDATA,GYZ,5,,6.55E9 \r\n');
        fprintf(fid,'MPDATA,GXZ,5,,6.55E9 \r\n');
        fprintf(fid,'MPTEMP,,,,,,,, \r\n');
        fprintf(fid,'MPTEMP,1,0 \r\n');
        fprintf(fid,'MPDATA,DENS,5,,1600 \r\n');
        
        % 建五種SHELL
        
        % 第一種SHELL
        fprintf(fid,'sect,1,shell,, \r\n');
        fprintf(fid,'secdata, 0.0002,1,-22.5,3 \r\n');
        fprintf(fid,'secdata, 0.0002,1,22.5,3 \r\n');
        fprintf(fid,'secdata, 0.0002,1,-22.5,3 \r\n');
        fprintf(fid,'secdata, 0.0002,1,22.5,3 \r\n');
        fprintf(fid,'secdata, 0.0002,1,90,3 \r\n');
        fprintf(fid,'secoffset,MID \r\n');
        fprintf(fid,'seccontrol,,,, , , , \r\n');
        
        % 第二種SHELL
        fprintf(fid,'sect,2,shell,, \r\n');
        fprintf(fid,'secdata, 0.0002,2,-22.5,3 \r\n');
        fprintf(fid,'secdata, 0.0002,2,22.5,3 \r\n');
        fprintf(fid,'secdata, 0.0002,2,-22.5,3 \r\n');
        fprintf(fid,'secdata, 0.0002,2,22.5,3 \r\n');
        fprintf(fid,'secdata, 0.0002,2,90,3 \r\n');
        fprintf(fid,'secoffset,MID \r\n');
        fprintf(fid,'seccontrol,,,, , , , \r\n');
        
        % 第三種SHELL
        fprintf(fid,'sect,3,shell,, \r\n');
        fprintf(fid,'secdata, 0.0002,3,-22.5,3 \r\n');
        fprintf(fid,'secdata, 0.0002,3,22.5,3 \r\n');
        fprintf(fid,'secdata, 0.0002,3,-22.5,3 \r\n');
        fprintf(fid,'secdata, 0.0002,3,22.5,3 \r\n');
        fprintf(fid,'secdata, 0.0002,3,90,3 \r\n');
        fprintf(fid,'secoffset,MID \r\n');
        fprintf(fid,'seccontrol,,,, , , , \r\n');
        
        % 第四種SHELL
        fprintf(fid,'sect,4,shell,, \r\n');
        fprintf(fid,'secdata, 0.0002,4,-22.5,3 \r\n');
        fprintf(fid,'secdata, 0.0002,4,22.5,3 \r\n');
        fprintf(fid,'secdata, 0.0002,4,-22.5,3 \r\n');
        fprintf(fid,'secdata, 0.0002,4,22.5,3 \r\n');
        fprintf(fid,'secdata, 0.0002,4,90,3 \r\n');
        fprintf(fid,'secoffset,MID \r\n');
        fprintf(fid,'seccontrol,,,, , , , \r\n');
        
        % 第五種SHELL
        fprintf(fid,'sect,5,shell,, \r\n');
        fprintf(fid,'secdata, 0.0002,5,-22.5,3 \r\n');
        fprintf(fid,'secdata, 0.0002,5,22.5,3 \r\n');
        fprintf(fid,'secdata, 0.0002,5,-22.5,3 \r\n');
        fprintf(fid,'secdata, 0.0002,5,22.5,3 \r\n');
        fprintf(fid,'secdata, 0.0002,5,90,3 \r\n');
        fprintf(fid,'secoffset,MID \r\n');
        fprintf(fid,'seccontrol,,,, , , , \r\n');
        
        % 建圓柱
        fprintf(fid,'K,1,0,0,0, \r\n');
        fprintf(fid,'K,2,0,0,1, \r\n');
        fprintf(fid,'LSTR,       1,       2 \r\n');
        fprintf(fid,'FLST,2,2,8 \r\n');
        fprintf(fid,'FITEM,2,0,0,0 \r\n');
        fprintf(fid,'FITEM,2,0.635E-01,0,0 \r\n');
        fprintf(fid,'CIRCLE,P51X, , , ,360, , \r\n');
        fprintf(fid,'FLST,2,4,4,ORDE,2 \r\n');
        fprintf(fid,'FITEM,2,2 \r\n');
        fprintf(fid,'FITEM,2,-5 \r\n');
        fprintf(fid,'ADRAG,P51X, , , , , ,       1 \r\n');
        
        % 分割五段
        fprintf(fid,'WPSTYLE,,,,,,,,1 \r\n');
        fprintf(fid,'wpof,,,0.2 \r\n');
        fprintf(fid,'FLST,2,4,5,ORDE,2 \r\n');
        fprintf(fid,'FITEM,2,1 \r\n');
        fprintf(fid,'FITEM,2,-4 \r\n');
        fprintf(fid,'ASBW,P51X \r\n');
        fprintf(fid,'wpof,,,0.2 \r\n');
        fprintf(fid,'FLST,2,4,5,ORDE,2 \r\n');
        fprintf(fid,'FITEM,2,9 \r\n');
        fprintf(fid,'FITEM,2,-12 \r\n');
        fprintf(fid,'ASBW,P51X \r\n');
        fprintf(fid,'wpof,,,0.2 \r\n');
        fprintf(fid,'FLST,2,4,5,ORDE,2 \r\n');
        fprintf(fid,'FITEM,2,1 \r\n');
        fprintf(fid,'FITEM,2,-4 \r\n');
        fprintf(fid,'ASBW,P51X \r\n');
        fprintf(fid,'wpof,,,0.2 \r\n');
        fprintf(fid,'FLST,2,4,5,ORDE,4 \r\n');
        fprintf(fid,'FITEM,2,9 \r\n');
        fprintf(fid,'FITEM,2,-10 \r\n');
        fprintf(fid,'FITEM,2,12 \r\n');
        fprintf(fid,'FITEM,2,17 \r\n');
        fprintf(fid,'ASBW,P51X \r\n');
        fprintf(fid,' \r\n');
        
        % 五段分別MESH材料編號
        fprintf(fid,'FLST,5,4,5,ORDE,2 \r\n');
        fprintf(fid,'FITEM,5,5 \r\n');
        fprintf(fid,'FITEM,5,-8 \r\n');
        fprintf(fid,'CM,_Y,AREA \r\n');
        fprintf(fid,'ASEL, , , ,P51X \r\n');
        fprintf(fid,'CM,_Y1,AREA \r\n');
        fprintf(fid,'CMSEL,S,_Y \r\n');
        fprintf(fid,'CMSEL,S,_Y1 \r\n');
        fprintf(fid,'AATT,       5, ,   1,       0,   5 \r\n');
        fprintf(fid,'CMSEL,S,_Y \r\n');
        fprintf(fid,'CMDELE,_Y \r\n');
        fprintf(fid,'CMDELE,_Y1 \r\n');
        fprintf(fid,'FLST,5,4,5,ORDE,2 \r\n');
        fprintf(fid,'FITEM,5,13 \r\n');
        fprintf(fid,'FITEM,5,-16 \r\n');
        fprintf(fid,'CM,_Y,AREA \r\n');
        fprintf(fid,'ASEL, , , ,P51X \r\n');
        fprintf(fid,'CM,_Y1,AREA \r\n');
        fprintf(fid,'CMSEL,S,_Y \r\n');
        fprintf(fid,'CMSEL,S,_Y1 \r\n');
        fprintf(fid,'AATT,       4, ,   1,       0,   4 \r\n');
        fprintf(fid,'CMSEL,S,_Y \r\n');
        fprintf(fid,'CMDELE,_Y \r\n');
        fprintf(fid,'CMDELE,_Y1 \r\n');
        fprintf(fid,'FLST,5,4,5,ORDE,3 \r\n');
        fprintf(fid,'FITEM,5,11 \r\n');
        fprintf(fid,'FITEM,5,18 \r\n');
        fprintf(fid,'FITEM,5,-20 \r\n');
        fprintf(fid,'CM,_Y,AREA \r\n');
        fprintf(fid,'ASEL, , , ,P51X \r\n');
        fprintf(fid,'CM,_Y1,AREA \r\n');
        fprintf(fid,'CMSEL,S,_Y \r\n');
        fprintf(fid,'CMSEL,S,_Y1 \r\n');
        fprintf(fid,'AATT,       3, ,   1,       0,   3 \r\n');
        fprintf(fid,'CMSEL,S,_Y \r\n');
        fprintf(fid,'CMDELE,_Y \r\n');
        fprintf(fid,'CMDELE,_Y1 \r\n');
        fprintf(fid,'FLST,5,4,5,ORDE,2 \r\n');
        fprintf(fid,'FITEM,5,21 \r\n');
        fprintf(fid,'FITEM,5,-24 \r\n');
        fprintf(fid,'CM,_Y,AREA \r\n');
        fprintf(fid,'ASEL, , , ,P51X \r\n');
        fprintf(fid,'CM,_Y1,AREA \r\n');
        fprintf(fid,'CMSEL,S,_Y \r\n');
        fprintf(fid,'CMSEL,S,_Y1 \r\n');
        fprintf(fid,'AATT,       2, ,   1,       0,   2 \r\n');
        fprintf(fid,'CMSEL,S,_Y \r\n');
        fprintf(fid,'CMDELE,_Y \r\n');
        fprintf(fid,'CMDELE,_Y1 \r\n');
        fprintf(fid,'FLST,5,4,5,ORDE,2 \r\n');
        fprintf(fid,'FITEM,5,1 \r\n');
        fprintf(fid,'FITEM,5,-4 \r\n');
        fprintf(fid,'CM,_Y,AREA \r\n');
        fprintf(fid,'ASEL, , , ,P51X \r\n');
        fprintf(fid,'CM,_Y1,AREA \r\n');
        fprintf(fid,'CMSEL,S,_Y \r\n');
        fprintf(fid,'CMSEL,S,_Y1 \r\n');
        fprintf(fid,'AATT,       1, ,   1,       0,   1 \r\n');
        fprintf(fid,'CMSEL,S,_Y  \r\n');
        fprintf(fid,'CMDELE,_Y \r\n');
        fprintf(fid,'CMDELE,_Y1 \r\n');
        
        % MESH
        fprintf(fid,'AESIZE,ALL,0.02, \r\n');
        fprintf(fid,'MSHKEY,0 \r\n');
        fprintf(fid,'FLST,5,20,5,ORDE,7 \r\n');
        fprintf(fid,'FITEM,5,1 \r\n');
        fprintf(fid,'FITEM,5,-8 \r\n');
        fprintf(fid,'FITEM,5,11 \r\n');
        fprintf(fid,'FITEM,5,13 \r\n');
        fprintf(fid,'FITEM,5,-16 \r\n');
        fprintf(fid,'FITEM,5,18 \r\n');
        fprintf(fid,'FITEM,5,-24 \r\n');
        fprintf(fid,'CM,_Y,AREA \r\n');
        fprintf(fid,'ASEL, , , ,P51X \r\n');
        fprintf(fid,'CM,_Y1,AREA \r\n');
        fprintf(fid,'CHKMSH,''AREA'' \r\n');
        fprintf(fid,'CMSEL,S,_Y \r\n');
        fprintf(fid,'AMESH,_Y1 \r\n');
        fprintf(fid,'CMDELE,_Y \r\n');
        fprintf(fid,'CMDELE,_Y1 \r\n');
        fprintf(fid,'CMDELE,_Y2 \r\n');
        
        % 新建座標系
        fprintf(fid,'CSWPLA,12,0,1,1, \r\n');
        fprintf(fid,'EMODIF,ALL,ESYS,12 \r\n');
        
        % Solve
        fprintf(fid,'FINISH \r\n');
        fprintf(fid,'/SOL \r\n');
        fprintf(fid,'ANTYPE,2 \r\n');
        fprintf(fid,'MODOPT,LANB,100 \r\n');
        fprintf(fid,'EQSLV,SPAR \r\n');
        fprintf(fid,'MXPAND,100, , ,0 \r\n');
        fprintf(fid,'LUMPM,0 \r\n');
        fprintf(fid,'PSTRES,0 \r\n');
        fprintf(fid,'MODOPT,LANB,100,10,5000, ,OFF \r\n');
        fprintf(fid,'SOLVE \r\n');
        fclose all;
        %========寫完APDL========
        
        % 呼叫ANSYS
        ! "C:\Program Files\ANSYS Inc\v150\ANSYS\bin\winx64\ansys150.exe" -p ane3fl -dir "D:\Study\Ansys" -j "pso_composite_pipe" -dvt -s read -l en-us -b -i "D:\Study\Ansys\psotoapdl.log" -o "D:\Study\Ansys\psotoapdl.out"
        
        % 讀取APDL結果檔
        result_read=fopen('D:\study\ansys\psotoapdl.out','r');
        
        %　從結果檔中讀取所需資料
        while(1)
            data=fscanf(result_read,'%s',1);
            if strcmp(data,'10.0000')==1                         % 第一次判斷特徵字串
                data=fscanf(result_read,'%s',1);
                if strcmp(data,'5000.00')==1                     % 第二次判斷特徵字串
                    natural_frequency=fscanf(result_read,'%f');  % 讀取所需資料
                    break
                end;
            end;
        end;
        
        % 處理所需資料
        for j=1:4*count_f
            if rem(j,4)==0
                F(j/4)=natural_frequency(j);
            end
        end
        
        fclose all;
        
        
        % 計算目標函數
        objf(i)=(1/count_f)*sum((F-expf).^2);
        
        
    end
    
    x_E2=E2;       % initial population
    v_E2=0.1*E2;   % initial velocity
    
    
    for i=1:n
        f0(i)=objf(i);
    end
    [fmin0,index0]=min(f0);
    pbest_E2=E2;                            % initial E2 pbest
    gbest_E2=E2(index0,:);                  % initial E2 gbest
    
    % pso initialization------------------------------------------------end
    
    % pso algorithm---------------------------------------------------start
    ite=1;
    memory=0;           % memory point off
    memory_ite=1;       % 記憶點初始位置
    end_count=0;
    excitation_count=0;
    gbest_memory=10000; % 記憶點gbest初始值
    
    while ite<=maxite && end_count<2
        w=wmax-(wmax-wmin)*ite/maxite; % update inertial weight
        
        % pso velocity updates
        
        for i=1:n
            for j=1:m
                v_E2(i,j)=w*v_E2(i,j)+c1*rand()*(pbest_E2(i,j)-x_E2(i,j))...
                    +c2*rand()*(gbest_E2(1,j)-x_E2(i,j));
            end
        end
        
        
        % pso position update
        
        if ite>5 && excitation_count>4
            % 更新記憶gbest與記憶點
            if memory<0.9
                gbest_memory=fmin0;
            else
                tolerance_memory=abs(fmin0-gbest_memory)/gbest_memory;
                if fmin0<gbest_memory && tolerance_memory>0.5
                    gbest_memory=fmin0;
                    memory_ite=ite-1;            % 記憶點更新
                    end_count=0;
                else
                    end_count=end_count+1;
                end
            end
            % 記憶點更新前初始化，記憶點更新後激發
            if memory_ite<2 % 記憶點更新前
                % 初始化
                for i=1:n
                    for j=1:m
                        x_E2(i,j)=LB_E2(j)+rand()*(UB_E2(j)-LB_E2(j));
                    end
                end
                excitation_count=-1;
                memory=1;              % merory point on
                for i=1:n
                    f0(i)=10000;       % 刪除pbest
                end
                fmin0=10000;           % 刪除gbest
            else            % 記憶點更新後
                % 激發
                if rand()<0.5
                    for i=1:n
                        for j=1:m
                            x_E2(i,j)=10^9*(fix(pbest_E2_ite(i,j,memory_ite)/10^9)+rand*(pbest_E2_ite(i,j,memory_ite)/10^9-fix(pbest_E2_ite(i,j,memory_ite)/10^9)));
                        end
                    end
                else
                    for i=1:n
                        for j=1:m
                            x_E2(i,j)=10^9*(fix(pbest_E2_ite(i,j,memory_ite)/10^9)-rand*(pbest_E2_ite(i,j,memory_ite)/10^9-fix(pbest_E2_ite(i,j,memory_ite)/10^9)));
                        end
                    end
                end
                excitation_count=-1;
                memory=1;          % merory point on
                for i=1:n
                    f0(i)=10000;   % 刪除pbest
                end
                fmin0=10000;       % 刪除gbest
            end
        else
            for i=1:n
                for j=1:m
                    x_E2(i,j)=x_E2(i,j)+v_E2(i,j);
                end
            end
        end
        
        
        
        % handling boundary violations
        for i=1:n
            for j=1:m
                if x_E2(i,j)<LB_E2(j)
                    x_E2(i,j)=LB_E2(j);
                elseif x_E2(i,j)>UB_E2(j)
                    x_E2(i,j)=UB_E2(j);
                end
            end
        end
        
        
        % 寫APDL，呼叫，讀取，計算目標函數
        for i=1:n
            E2A=x_E2(i,1);
            E2B=x_E2(i,2);
            E2C=x_E2(i,3);
            E2D=x_E2(i,4);
            E2E=x_E2(i,5);
            fid=fopen('D:\study\ansys\psotoapdl.log','w');
            fprintf(fid,'/BATCH \r\n');
            fprintf(fid,'/PREP7 \r\n');
            fprintf(fid,'ET,1,SHELL281 \r\n');
            fprintf(fid,'KEYOPT,1,1,0 \r\n');
            fprintf(fid,'KEYOPT,1,8,0 \r\n');
            fprintf(fid,'KEYOPT,1,9,0 \r\n');
            
            % 開始建五種材料參數
            
            % 第一種材料參數
            fprintf(fid,'MPTEMP,,,,,,,, \r\n');
            fprintf(fid,'MPTEMP,1,0 \r\n');
            fprintf(fid,'MPDATA,EX,1,,131E9 \r\n');
            fprintf(fid,'MPDATA,EY,1,,%d \r\n',E2A);
            fprintf(fid,'MPDATA,EZ,1,,%d \r\n',E2A);
            fprintf(fid,'MPDATA,PRXY,1,,0.28 \r\n');
            fprintf(fid,'MPDATA,PRYZ,1,,0.024 \r\n');
            fprintf(fid,'MPDATA,PRXZ,1,,0.024 \r\n');
            fprintf(fid,'MPDATA,GXY,1,,6.55E9 \r\n');
            fprintf(fid,'MPDATA,GYZ,1,,6.55E9 \r\n');
            fprintf(fid,'MPDATA,GXZ,1,,6.55E9 \r\n');
            fprintf(fid,'MPTEMP,,,,,,,, \r\n');
            fprintf(fid,'MPTEMP,1,0 \r\n');
            fprintf(fid,'MPDATA,DENS,1,,1600 \r\n');
            
            % 第二種材料參數
            fprintf(fid,'MPTEMP,,,,,,,, \r\n');
            fprintf(fid,'MPTEMP,1,0 \r\n');
            fprintf(fid,'MPDATA,EX,2,,131E9 \r\n');
            fprintf(fid,'MPDATA,EY,2,,%d \r\n',E2B);
            fprintf(fid,'MPDATA,EZ,2,,%d \r\n',E2B);
            fprintf(fid,'MPDATA,PRXY,2,,0.28 \r\n');
            fprintf(fid,'MPDATA,PRYZ,2,,0.024 \r\n');
            fprintf(fid,'MPDATA,PRXZ,2,,0.024 \r\n');
            fprintf(fid,'MPDATA,GXY,2,,6.55E9 \r\n');
            fprintf(fid,'MPDATA,GYZ,2,,6.55E9 \r\n');
            fprintf(fid,'MPDATA,GXZ,2,,6.55E9 \r\n');
            fprintf(fid,'MPTEMP,,,,,,,, \r\n');
            fprintf(fid,'MPTEMP,1,0 \r\n');
            fprintf(fid,'MPDATA,DENS,2,,1600 \r\n');
            
            % 第三種材料參數
            fprintf(fid,'MPTEMP,,,,,,,, \r\n');
            fprintf(fid,'MPTEMP,1,0 \r\n');
            fprintf(fid,'MPDATA,EX,3,,131E9 \r\n');
            fprintf(fid,'MPDATA,EY,3,,%d \r\n',E2C);
            fprintf(fid,'MPDATA,EZ,3,,%d \r\n',E2C);
            fprintf(fid,'MPDATA,PRXY,3,,0.28 \r\n');
            fprintf(fid,'MPDATA,PRYZ,3,,0.024 \r\n');
            fprintf(fid,'MPDATA,PRXZ,3,,0.024 \r\n');
            fprintf(fid,'MPDATA,GXY,3,,6.55E9 \r\n');
            fprintf(fid,'MPDATA,GYZ,3,,6.55E9 \r\n');
            fprintf(fid,'MPDATA,GXZ,3,,6.55E9 \r\n');
            fprintf(fid,'MPTEMP,,,,,,,, \r\n');
            fprintf(fid,'MPTEMP,1,0 \r\n');
            fprintf(fid,'MPDATA,DENS,3,,1600 \r\n');
            
            % 第四種材料參數
            fprintf(fid,'MPTEMP,,,,,,,, \r\n');
            fprintf(fid,'MPTEMP,1,0 \r\n');
            fprintf(fid,'MPDATA,EX,4,,131E9 \r\n');
            fprintf(fid,'MPDATA,EY,4,,%d \r\n',E2D);
            fprintf(fid,'MPDATA,EZ,4,,%d \r\n',E2D);
            fprintf(fid,'MPDATA,PRXY,4,,0.28 \r\n');
            fprintf(fid,'MPDATA,PRYZ,4,,0.024 \r\n');
            fprintf(fid,'MPDATA,PRXZ,4,,0.024 \r\n');
            fprintf(fid,'MPDATA,GXY,4,,6.55E9 \r\n');
            fprintf(fid,'MPDATA,GYZ,4,,6.55E9 \r\n');
            fprintf(fid,'MPDATA,GXZ,4,,6.55E9 \r\n');
            fprintf(fid,'MPTEMP,,,,,,,, \r\n');
            fprintf(fid,'MPTEMP,1,0 \r\n');
            fprintf(fid,'MPDATA,DENS,4,,1600 \r\n');
            
            % 第五種材料參數
            fprintf(fid,'MPTEMP,,,,,,,, \r\n');
            fprintf(fid,'MPTEMP,1,0 \r\n');
            fprintf(fid,'MPDATA,EX,5,,131E9 \r\n');
            fprintf(fid,'MPDATA,EY,5,,%d \r\n',E2E);
            fprintf(fid,'MPDATA,EZ,5,,%d \r\n',E2E);
            fprintf(fid,'MPDATA,PRXY,5,,0.28 \r\n');
            fprintf(fid,'MPDATA,PRYZ,5,,0.024 \r\n');
            fprintf(fid,'MPDATA,PRXZ,5,,0.024 \r\n');
            fprintf(fid,'MPDATA,GXY,5,,6.55E9 \r\n');
            fprintf(fid,'MPDATA,GYZ,5,,6.55E9 \r\n');
            fprintf(fid,'MPDATA,GXZ,5,,6.55E9 \r\n');
            fprintf(fid,'MPTEMP,,,,,,,, \r\n');
            fprintf(fid,'MPTEMP,1,0 \r\n');
            fprintf(fid,'MPDATA,DENS,5,,1600 \r\n');
            
            % 建五種SHELL
            
            % 第一種SHELL
            fprintf(fid,'sect,1,shell,, \r\n');
            fprintf(fid,'secdata, 0.0002,1,-22.5,3 \r\n');
            fprintf(fid,'secdata, 0.0002,1,22.5,3 \r\n');
            fprintf(fid,'secdata, 0.0002,1,-22.5,3 \r\n');
            fprintf(fid,'secdata, 0.0002,1,22.5,3 \r\n');
            fprintf(fid,'secdata, 0.0002,1,90,3 \r\n');
            fprintf(fid,'secoffset,MID \r\n');
            fprintf(fid,'seccontrol,,,, , , , \r\n');
            
            % 第二種SHELL
            fprintf(fid,'sect,2,shell,, \r\n');
            fprintf(fid,'secdata, 0.0002,2,-22.5,3 \r\n');
            fprintf(fid,'secdata, 0.0002,2,22.5,3 \r\n');
            fprintf(fid,'secdata, 0.0002,2,-22.5,3 \r\n');
            fprintf(fid,'secdata, 0.0002,2,22.5,3 \r\n');
            fprintf(fid,'secdata, 0.0002,2,90,3 \r\n');
            fprintf(fid,'secoffset,MID \r\n');
            fprintf(fid,'seccontrol,,,, , , , \r\n');
            
            % 第三種SHELL
            fprintf(fid,'sect,3,shell,, \r\n');
            fprintf(fid,'secdata, 0.0002,3,-22.5,3 \r\n');
            fprintf(fid,'secdata, 0.0002,3,22.5,3 \r\n');
            fprintf(fid,'secdata, 0.0002,3,-22.5,3 \r\n');
            fprintf(fid,'secdata, 0.0002,3,22.5,3 \r\n');
            fprintf(fid,'secdata, 0.0002,3,90,3 \r\n');
            fprintf(fid,'secoffset,MID \r\n');
            fprintf(fid,'seccontrol,,,, , , , \r\n');
            
            % 第四種SHELL
            fprintf(fid,'sect,4,shell,, \r\n');
            fprintf(fid,'secdata, 0.0002,4,-22.5,3 \r\n');
            fprintf(fid,'secdata, 0.0002,4,22.5,3 \r\n');
            fprintf(fid,'secdata, 0.0002,4,-22.5,3 \r\n');
            fprintf(fid,'secdata, 0.0002,4,22.5,3 \r\n');
            fprintf(fid,'secdata, 0.0002,4,90,3 \r\n');
            fprintf(fid,'secoffset,MID \r\n');
            fprintf(fid,'seccontrol,,,, , , , \r\n');
            
            % 第五種SHELL
            fprintf(fid,'sect,5,shell,, \r\n');
            fprintf(fid,'secdata, 0.0002,5,-22.5,3 \r\n');
            fprintf(fid,'secdata, 0.0002,5,22.5,3 \r\n');
            fprintf(fid,'secdata, 0.0002,5,-22.5,3 \r\n');
            fprintf(fid,'secdata, 0.0002,5,22.5,3 \r\n');
            fprintf(fid,'secdata, 0.0002,5,90,3 \r\n');
            fprintf(fid,'secoffset,MID \r\n');
            fprintf(fid,'seccontrol,,,, , , , \r\n');
            
            % 建圓柱
            fprintf(fid,'K,1,0,0,0, \r\n');
            fprintf(fid,'K,2,0,0,1, \r\n');
            fprintf(fid,'LSTR,       1,       2 \r\n');
            fprintf(fid,'FLST,2,2,8 \r\n');
            fprintf(fid,'FITEM,2,0,0,0 \r\n');
            fprintf(fid,'FITEM,2,0.635E-01,0,0 \r\n');
            fprintf(fid,'CIRCLE,P51X, , , ,360, , \r\n');
            fprintf(fid,'FLST,2,4,4,ORDE,2 \r\n');
            fprintf(fid,'FITEM,2,2 \r\n');
            fprintf(fid,'FITEM,2,-5 \r\n');
            fprintf(fid,'ADRAG,P51X, , , , , ,       1 \r\n');
            
            % 分割五段
            fprintf(fid,'WPSTYLE,,,,,,,,1 \r\n');
            fprintf(fid,'wpof,,,0.2 \r\n');
            fprintf(fid,'FLST,2,4,5,ORDE,2 \r\n');
            fprintf(fid,'FITEM,2,1 \r\n');
            fprintf(fid,'FITEM,2,-4 \r\n');
            fprintf(fid,'ASBW,P51X \r\n');
            fprintf(fid,'wpof,,,0.2 \r\n');
            fprintf(fid,'FLST,2,4,5,ORDE,2 \r\n');
            fprintf(fid,'FITEM,2,9 \r\n');
            fprintf(fid,'FITEM,2,-12 \r\n');
            fprintf(fid,'ASBW,P51X \r\n');
            fprintf(fid,'wpof,,,0.2 \r\n');
            fprintf(fid,'FLST,2,4,5,ORDE,2 \r\n');
            fprintf(fid,'FITEM,2,1 \r\n');
            fprintf(fid,'FITEM,2,-4 \r\n');
            fprintf(fid,'ASBW,P51X \r\n');
            fprintf(fid,'wpof,,,0.2 \r\n');
            fprintf(fid,'FLST,2,4,5,ORDE,4 \r\n');
            fprintf(fid,'FITEM,2,9 \r\n');
            fprintf(fid,'FITEM,2,-10 \r\n');
            fprintf(fid,'FITEM,2,12 \r\n');
            fprintf(fid,'FITEM,2,17 \r\n');
            fprintf(fid,'ASBW,P51X \r\n');
            fprintf(fid,' \r\n');
            
            % 五段分別MESH材料編號
            fprintf(fid,'FLST,5,4,5,ORDE,2 \r\n');
            fprintf(fid,'FITEM,5,5 \r\n');
            fprintf(fid,'FITEM,5,-8 \r\n');
            fprintf(fid,'CM,_Y,AREA \r\n');
            fprintf(fid,'ASEL, , , ,P51X \r\n');
            fprintf(fid,'CM,_Y1,AREA \r\n');
            fprintf(fid,'CMSEL,S,_Y \r\n');
            fprintf(fid,'CMSEL,S,_Y1 \r\n');
            fprintf(fid,'AATT,       5, ,   1,       0,   5 \r\n');
            fprintf(fid,'CMSEL,S,_Y \r\n');
            fprintf(fid,'CMDELE,_Y \r\n');
            fprintf(fid,'CMDELE,_Y1 \r\n');
            fprintf(fid,'FLST,5,4,5,ORDE,2 \r\n');
            fprintf(fid,'FITEM,5,13 \r\n');
            fprintf(fid,'FITEM,5,-16 \r\n');
            fprintf(fid,'CM,_Y,AREA \r\n');
            fprintf(fid,'ASEL, , , ,P51X \r\n');
            fprintf(fid,'CM,_Y1,AREA \r\n');
            fprintf(fid,'CMSEL,S,_Y \r\n');
            fprintf(fid,'CMSEL,S,_Y1 \r\n');
            fprintf(fid,'AATT,       4, ,   1,       0,   4 \r\n');
            fprintf(fid,'CMSEL,S,_Y \r\n');
            fprintf(fid,'CMDELE,_Y \r\n');
            fprintf(fid,'CMDELE,_Y1 \r\n');
            fprintf(fid,'FLST,5,4,5,ORDE,3 \r\n');
            fprintf(fid,'FITEM,5,11 \r\n');
            fprintf(fid,'FITEM,5,18 \r\n');
            fprintf(fid,'FITEM,5,-20 \r\n');
            fprintf(fid,'CM,_Y,AREA \r\n');
            fprintf(fid,'ASEL, , , ,P51X \r\n');
            fprintf(fid,'CM,_Y1,AREA \r\n');
            fprintf(fid,'CMSEL,S,_Y \r\n');
            fprintf(fid,'CMSEL,S,_Y1 \r\n');
            fprintf(fid,'AATT,       3, ,   1,       0,   3 \r\n');
            fprintf(fid,'CMSEL,S,_Y \r\n');
            fprintf(fid,'CMDELE,_Y \r\n');
            fprintf(fid,'CMDELE,_Y1 \r\n');
            fprintf(fid,'FLST,5,4,5,ORDE,2 \r\n');
            fprintf(fid,'FITEM,5,21 \r\n');
            fprintf(fid,'FITEM,5,-24 \r\n');
            fprintf(fid,'CM,_Y,AREA \r\n');
            fprintf(fid,'ASEL, , , ,P51X \r\n');
            fprintf(fid,'CM,_Y1,AREA \r\n');
            fprintf(fid,'CMSEL,S,_Y \r\n');
            fprintf(fid,'CMSEL,S,_Y1 \r\n');
            fprintf(fid,'AATT,       2, ,   1,       0,   2 \r\n');
            fprintf(fid,'CMSEL,S,_Y \r\n');
            fprintf(fid,'CMDELE,_Y \r\n');
            fprintf(fid,'CMDELE,_Y1 \r\n');
            fprintf(fid,'FLST,5,4,5,ORDE,2 \r\n');
            fprintf(fid,'FITEM,5,1 \r\n');
            fprintf(fid,'FITEM,5,-4 \r\n');
            fprintf(fid,'CM,_Y,AREA \r\n');
            fprintf(fid,'ASEL, , , ,P51X \r\n');
            fprintf(fid,'CM,_Y1,AREA \r\n');
            fprintf(fid,'CMSEL,S,_Y \r\n');
            fprintf(fid,'CMSEL,S,_Y1 \r\n');
            fprintf(fid,'AATT,       1, ,   1,       0,   1 \r\n');
            fprintf(fid,'CMSEL,S,_Y  \r\n');
            fprintf(fid,'CMDELE,_Y \r\n');
            fprintf(fid,'CMDELE,_Y1 \r\n');
            
            % MESH
            fprintf(fid,'AESIZE,ALL,0.02, \r\n');
            fprintf(fid,'MSHKEY,0 \r\n');
            fprintf(fid,'FLST,5,20,5,ORDE,7 \r\n');
            fprintf(fid,'FITEM,5,1 \r\n');
            fprintf(fid,'FITEM,5,-8 \r\n');
            fprintf(fid,'FITEM,5,11 \r\n');
            fprintf(fid,'FITEM,5,13 \r\n');
            fprintf(fid,'FITEM,5,-16 \r\n');
            fprintf(fid,'FITEM,5,18 \r\n');
            fprintf(fid,'FITEM,5,-24 \r\n');
            fprintf(fid,'CM,_Y,AREA \r\n');
            fprintf(fid,'ASEL, , , ,P51X \r\n');
            fprintf(fid,'CM,_Y1,AREA \r\n');
            fprintf(fid,'CHKMSH,''AREA'' \r\n');
            fprintf(fid,'CMSEL,S,_Y \r\n');
            fprintf(fid,'AMESH,_Y1 \r\n');
            fprintf(fid,'CMDELE,_Y \r\n');
            fprintf(fid,'CMDELE,_Y1 \r\n');
            fprintf(fid,'CMDELE,_Y2 \r\n');
            
            % 新建座標系
            fprintf(fid,'CSWPLA,12,0,1,1, \r\n');
            fprintf(fid,'EMODIF,ALL,ESYS,12 \r\n');
            
            % Solve
            fprintf(fid,'FINISH \r\n');
            fprintf(fid,'/SOL \r\n');
            fprintf(fid,'ANTYPE,2 \r\n');
            fprintf(fid,'MODOPT,LANB,100 \r\n');
            fprintf(fid,'EQSLV,SPAR \r\n');
            fprintf(fid,'MXPAND,100, , ,0 \r\n');
            fprintf(fid,'LUMPM,0 \r\n');
            fprintf(fid,'PSTRES,0 \r\n');
            fprintf(fid,'MODOPT,LANB,100,10,5000, ,OFF \r\n');
            fprintf(fid,'SOLVE \r\n');
            fclose all;
            %========寫完APDL========
            
            % 呼叫ANSYS
            ! "C:\Program Files\ANSYS Inc\v150\ANSYS\bin\winx64\ansys150.exe" -p ane3fl -dir "D:\Study\Ansys" -j "pso_composite_pipe" -dvt -s read -l en-us -b -i "D:\Study\Ansys\psotoapdl.log" -o "D:\Study\Ansys\psotoapdl.out"
            
            % 讀取APDL結果檔
            result_read=fopen('D:\study\ansys\psotoapdl.out','r');
            
            % 從結果檔中讀取所需資料
            while(1)
                data=fscanf(result_read,'%s',1);
                if strcmp(data,'10.0000')==1                        % 第一次判斷特徵字串
                    data=fscanf(result_read,'%s',1);
                    if strcmp(data,'5000.00')==1                    % 第二次判斷特徵字串
                        natural_frequency=fscanf(result_read,'%f'); % 讀取所需資料
                        break
                    end;
                end;
            end;
            
            % 處理所需資料
            for j=1:4*count_f
                if rem(j,4)==0
                    F(j/4)=natural_frequency(j);
                end
            end
            
            fclose all;
            
            
            % 計算目標函數
            objf(i)=(1/count_f)*sum((F-expf).^2);
            
            
        end
        
        % evaluating fitness
        for i=1:n
            f(i)=objf(i);
        end
        
        % storing f
        [this_f,this_index]=min(f);
        
        
        
        % 2次迭代後開始計算excitation_count
        if ite>2
            tolerance=abs(this_f-fmin0)/fmin0;
            if this_f<fmin0 && tolerance>0.1
                excitation_count=0;
            else
                excitation_count=excitation_count+1;
            end
        end
        
        
        
        % updating pbest and fitness
        for i=1:n
            if f(i)<f0(i)
                for j=1:5
                    pbest_E2(i,j)=x_E2(i,j);
                end
                f0(i)=f(i);
            end
        end
        
        
        pbest_E2_ite(:,:,ite)=pbest_E2(:,:);    % storing pbest_ite
        
        
        
        [fmin,index]=min(f0);               % finding out the best particle
        ffmin(ite)=fmin;                    % storing best fitness
        ffite=ite;                          % storing iteration count
        
        
        
        % updating gbest and best fitness
        if fmin<fmin0
            gbest_E2=pbest_E2(index,:);
            fmin0=fmin;
        end
        
        gbest_E2_ite(ite,:)=gbest_E2(:);     % storing gbest_ite
        fmin0_ite(ite)=fmin0;                % storing obf_gbest_ite
        
        
        % displaying iterative results
        if end_count<2
            E2AA=gbest_E2(1);
            E2BB=gbest_E2(2);
            E2CC=gbest_E2(3);
            E2DD=gbest_E2(4);
            E2EE=gbest_E2(5);
            
            if ite==1
                disp(sprintf('Iteration   Best particle   Best Objective fun   Objective fun        E2A        E2B        E2C        E2D        E2E'));
            end
            disp(sprintf('%5g %15g %20g %15g %16.2E %10.2E %10.2E %10.2E %10.2E %10.2E %10.2E %10.2E %10.2E %10.2E',ite,index,fmin0,this_f,E2AA,E2BB,E2CC,E2DD,E2EE));
        end
        
        ite=ite+1;
    end
    % pso algorithm-----------------------------------------------------end
    gbest_E2;
    fmin0;
    
    [fmin0_result,index_result]=min(fmin0_ite);      % storing obf_gbest_result
    gbest_result_E2=gbest_E2_ite(index_result,:);    % storing gbest_E2_result
    
    disp(sprintf('--------------------------------------'));
    
    % pso main program------------------------------------------------------end
    disp(sprintf('\n'));
    disp(sprintf('*********************************************************'));
    disp(sprintf('Final Results-----------------------------'));
    bestfun=fmin0_result
    best_variables_E2=gbest_result_E2
    disp(sprintf('*********************************************************'));
    toc
end



%##########################################################################