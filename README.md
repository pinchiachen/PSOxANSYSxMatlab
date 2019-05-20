"# PSOxANSYSxMatlab"
====
本程式用途為利用自然 (共振) 頻率來反算材料參數，使用 ANSYS 計算頻率，主程式使用 Matlab 撰寫，演算法以粒子群演算法 (PSO) 為基礎，並加入了 "回溯" 與 "激發" 機制，嘗試解決粒子陷入區域極值之情形。  

Condition simulation
----
將 1m 長之複合材料圓管，沿軸方向等分成五段，分別為 A-E 區域，其中 A 區域之楊氏係數以 E2A 表示，現設定 E2A = 11.2 E9，E2B = 8.4 E9，E2C = 5.6 E9，E2D = 8.4 E9，E2E = 11.2 E9，以此設定使用 ANSYS 進行模態分析得到前 n 個自然頻率。

反算問題為 : 已知前 n 個頻率之情況下，反算 E2A~E2E 之值。( 期望解即為上述設定之值 )。

How to use
----
設定參數，使用前 n 個頻率來反算，並且給定頻率之值，RUN。

Demo
----
附件 result.txt 即為一次反算的結果範例。

Contact me
----
chenargar@gmail.com
