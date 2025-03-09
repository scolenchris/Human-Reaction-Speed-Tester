![image](https://github.com/user-attachments/assets/53c19b7e-b13b-4010-b593-c19f95e7958c)# 单元电路设计原理说明与仿真波形

## 1.1 分频器 fdiv 设计原理与仿真波形

**图 1.1 分频器最终电路图**
![image](https://github.com/user-attachments/assets/7dc192c0-e7ad-4824-b0ad-6d9d490dcbbf)

分频器目标是分出 100hz，10hz，1hz，0.5hz，2hz，0.1hz 的时钟信号，我首先采用了 74160 进行进制转换，将溢出信号作为下一个 74160 的 clk 信号进行计数，从而完成十分频的分频功能，但是发现了第一个问题。

**图 1.2 旧版分频器电路图**
![image](https://github.com/user-attachments/assets/10d6591b-ee7f-4ae1-b480-241d458d6bb1)

**图 1.3 旧版分频器电路仿真波形图**
![image](https://github.com/user-attachments/assets/36477ff6-5f82-4509-b069-5de482aaa975)

按上图设计时，时序模拟如上，可见 clk100 实际是 clk50，实现了二十分频，问题定位再第一个 74160clk 接入的 clk 有问题，由于是一个完整脉冲计数一次，因此是计数了 10 次后才有一个上升沿，再加上下降的时间，就是相当于 20 次，与预期不一样，后面进行了修复，使用 7490 完成 5 分频，实际效果就是十分频；
第二个问题在于 clk1，当时使用为了方便 clk1 其实是 clk100，为了对比 7490 和 74160 效果，可见 clk1 位置的时序波形存在波形不完整的问题，但是频率确实正确，为 100hz，符合预期设计，后续考虑加入 jk 触发器，将波形补充起来。

**图 1.4 改进后的分频器电路图**
![image](https://github.com/user-attachments/assets/6415475c-986b-41a3-bf48-9da003c18a9e)

**图 1.5 改进后的分频器电路波形仿真图**
![image](https://github.com/user-attachments/assets/b1b2b589-7190-41d7-bea1-d92d66c21954)

结果上述修改，电路图如上，其他波形正常，但是再 clk0_5，也就是 0.5hz 的时钟出现了问题，频率不均匀，前两个波形是正确的 0.5hz，但是在第三个波形来的时候出现了“等待的问题”，因此不能总结接在最后一片 74160 上，解决方法是从 clk1 中接出信号，然后二分频出 0.5hz 信号。
最终的波形仿真图如下，可见 1000hz 到 100hz 之间转换完美，一个波形里面有 10 个完整的波形；在 100hz 到 10hz 的地方，也符合一个波形中有 10 个完整波形

**图 1.6 最终波形仿真图 1**
![image](https://github.com/user-attachments/assets/b9b6a371-a33b-4f4c-aa87-2f15d4821242)

**图 1.7 最终波形仿真图 2**
![image](https://github.com/user-attachments/assets/42e367b4-a02b-45c8-8dc1-86ed3276bbd8)

**图 1.8 最终波形仿真图 3**
![image](https://github.com/user-attachments/assets/68af634e-3c5b-414f-b62d-36df562400d3)

**图 1.9 最终波形仿真图 4**
![image](https://github.com/user-attachments/assets/253f9967-7c02-4782-8499-513be14457de)

**图 1.10 最终波形仿真图 5**
![image](https://github.com/user-attachments/assets/1d273c97-a5d4-4403-8167-24e48838e486)

## 1.2 伪随机数生成模块 random 的设计原理与仿真波形

**图 1.11 random 模块电路图**
![image](https://github.com/user-attachments/assets/0694c547-1a53-4c21-b39e-c3efc5e70c3c)

纯电路无法实现真正的随机性，因此下面都是基于伪随机数的生成方法来讲述。首先，通过使用 74161 计数器产生一系列方波信号，输出信号为 ABCD。接着，将输出信号连接到 4-16 线译码器，以生成 16 位二进制码。如果再将这些二进制码按顺序通过编码器处理，则会得到顺序的四位二进制编码。
为了生成伪随机数，需要对译码器和编码器之间的连线进行打乱处理。然而，这种方法无法避免出现全零（0000）的情况。在这种情况下，按钮无需按下即可满足触发条件，但由于触发条件之一是必须按下按钮，这就产生了矛盾。为了解决这一问题，可以引入一个模块，当检测到全零（0000）时，将其中的一位翻转，从而避免出现全零的情况。这样便可以确保伪随机数生成过程的合理性。

**图 1.12 仿真波形图**
![image](https://github.com/user-attachments/assets/2adb46a6-5c04-48c1-87c4-e74c8098ec08)

通过波形仿真，可见 ABCD 输出没有明显规律性，同时没有出现全 0 的情况，但是从长期角度来看，其实是有规律性，但是相邻之间规律性可以认为没有，因此符合伪随机数生成的特征。

## 1.3 比较器模块 compare 的设计原理与仿真波形

**图 1.13 compare 模块电路图**
![image](https://github.com/user-attachments/assets/4bf8af70-8004-4792-9fae-c54bf533f74a)

比较器的核心组件是 7485，它用于对四路信号进行比较并输出结果。下方的 74160 计数器以 0.5 秒的间隔进行计数，每次计数时触发一次检测，以确定按键是否正确按下。右侧的两路输出 sc_n 和 false 分别表示成功按下（低电平有效）和按下错误按键的状态。
D 触发器在这一设计中起到锁存器的作用。它能够将成功按下的信号锁存，直到 0.5 Hz 的一个周期结束，从而确保信号的稳定性和准确性。
下图为仿真波形，模拟了按下正确与错误的情况，也模拟了不按下按键的情况。

**图 1.14 仿真波形图**
![image](https://github.com/user-attachments/assets/9d786ec6-d932-446c-810d-2d2dbbaef878)

## 1.4 动态数码管扫描信号发生器 dy_gen 的设计原理与仿真波形

**图 1.15 dy_gen 模块电路图**
![image](https://github.com/user-attachments/assets/14bffea6-8572-4a86-af82-a504eefd404e)

这个模块的功能是产生扫描信号。在时钟的每一个周期内，其中一个选择信号（sel）线会有一个波形，而其他 sel 信号线则没有波形，从而生成类似 1000、0100、0010、0001 的周期性序列信号。
整个模块使用了 4 个 D 触发器。每个触发器的输出连接到下一个触发器的输入，第一个触发器的输入连接到 sel1、sel2、sel3 信号线的或非（NOR）得到的信号。也就是说，当所有 sel 信号线都为 0 时，将 1 写入到第一个 D 触发器中，从而实现波形“向后递推”的效果。通过这种方式，该模块能够产生高频扫描信号。每当一个 sel 信号线上出现波形时，动态扫描管便会在该信号线上进行显示，然后轮到下一个数码管进行显示。如此循环往复，实现连续的显示效果。
下图为仿真波形，可见其符合设计预期

**图 1.16 仿真波形图**
![image](https://github.com/user-attachments/assets/486f75b5-06fe-41db-bf93-d9891c5bf5c0)

## 1.5 计时器动态数码管显示模块 dy_time 设计原理与仿真波形

**图 1.17 dy_time 模块电路图**
![image](https://github.com/user-attachments/assets/54a0d09c-8d2e-48d9-84e8-2f183979bbbd)

**图 1.18 局部放大图 1**
![image](https://github.com/user-attachments/assets/add5cf0b-59e0-4ea3-88e7-93ed81c02858)

**图 1.19 局部放大图 2**
![image](https://github.com/user-attachments/assets/7b01ccd7-539e-42d7-8be5-019bc2c1524b)

**图 1.20 局部放大图 3**
![image](https://github.com/user-attachments/assets/e2855f36-c247-41c8-8b64-4cb4bad36012)

**图 1.21 局部放大图 4**
![image](https://github.com/user-attachments/assets/a63dc9bb-8998-4e0f-8eed-1699dcece21d)

该模块较为复杂，集成了动态扫描管（总线控制）显示、10 次计数、分频计数并输出 BCD 码以及锁存功能。
左上角的 74161 计数器接入 0.5Hz 时钟信号。当计数达到 10 时，输出 end_flag 信号，表示完成 10 次计数，即经过了 20 秒的测试时间。同时，该信号被送到右下角的触发器时钟源和中间部分 74160 的 ENT 引脚。该信号能够使计数器失能，从而停止计数，实现 20 秒结束测试的效果；计数完成后，一直将左边信号进行写入，写入的仍然为 1101，保持 20 秒不变，直到复位完成。
中间的四个 74160 构成计数器模块，首先接入 100Hz 时钟信号。每个 74160 的时钟输入（CLK）连接到上一个 74160 的 D 脚，表示每计数 10 次就触发一次时钟脉冲，从而实现十进制计数关系。同时，通过第一个 74160 可以控制下方三个 74160 的计时开始和结束。此外，外接的 sc 引脚能够异步停止计时器，实现按下正确按键后计时器停止的功能。
右下角的电路用于失败判断。当所用时间超过 10 秒时，D 触发器写入 1，或门输出为 1，false 信号为 1，success 信号为 0。D 触发器保持了 success 的状态，这将在 pass-fail 模块中起到铺垫作用。
在总线刷新部分，四路计数器信号接入总线，sel 信号提供给 74244 的使能端。当使能时，对应的信号将被发送出去。通过信号的逐段接替发送，实现扫描。当扫描周期变短时，肉眼无法察觉刷新频率，从而实现类似常亮的效果。最终，通过 7448 实现编码，信号被送到数码管，实现显示效果。
下图为仿真波形，可见其符合设计预期

## 1.6 通过/失败动态数码管显示 wr_pa 的设计原理与仿真波形

**图 1.22 wr_pa 模块电路图**
![image](https://github.com/user-attachments/assets/a3abf399-e53c-4997-9a75-19bf1244eaf6)

**图 1.23 局部放大图**
![image](https://github.com/user-attachments/assets/a01d9e98-4841-45fc-a236-711aa0f23514)

该模块的功能是在不同状态下显示“PASS”和“FAIL”字样。输入信号为 pass 和 fail，当它们的值为 1 时表示有效。因此，核心思想是，当 pass 或 fail 信号有效时，sel 线仅使能对应字样的 74244 芯片。具体实现方法是将对应的 sel 线信号与输入的 pass/fail 信号取反后进行或运算，然后输出。由于 fail 和 pass 信号的组合只能是 01 或 10，这样就能实现特定情况下的输出要求。
在仿真过程中，可以利用 clock 功能高效生成模拟的 sel 信号，如图。

**图 1.24 clock 功能使用演示**
![image](https://github.com/user-attachments/assets/0666a848-1871-47b9-be7d-6ae6a10e60db)

模拟波形如下，可见产生了周期的数码管信号，当都为 0 的时候，输出为高阻态，即不显示，所以不会和计时的信号冲突。

**图 1.25 波形仿真图**
![image](https://github.com/user-attachments/assets/a7ad5779-2bba-40e7-83d8-0fd1676da5d8)

## 1.7 错误计数显示 wrongcount 的设计原理

**图 1.26 wrongcount 模块电路图**
![image](https://github.com/user-attachments/assets/9c854c61-dff8-4a28-9b26-7b39cfe735fb)

为简单的计数后通过 7448 输出，不过多赘述。

## 1.8 随机数全 0 处理模块 all0to1 的设计原理

**图 1.27 all0to1 模块电路图**
![image](https://github.com/user-attachments/assets/661e454a-86ec-4859-acdd-0dce488b2625)

通过卡诺图进行化简和逻辑表达，见下表
**表 1**
AB\CD 00 01 11 10
00 1 0 0 0
01 0 0 0 0
11 1 1 1 1
10 1 1 1 1

# 整机电路各单元模块信号连接调试及分析说明

## 2.1 整机电路图

**图 2.1 整体电路图**
![image](https://github.com/user-attachments/assets/1e90e6d9-153d-4a7a-b395-65b335d0df2b)

## 2.2 单元电路模块之间的连接以及功能说明

### 2.2.1 时钟源分配与状态灯显示

Dy_gen 模块需要一个 1000hz 时钟，dy_time 需要 0.5、100、10、1、1000hz 时钟，compare 需要 0.5、2hz 时钟，random 模块需要一个 0.5hz 的时钟，fdiv 则需要外接时钟源，我选择的是 1khz 的外部时钟输入。
Clk2 的时钟接入到 dy_gen 模块，然后我选择将其接入到四个灯中，同时接入到数码管中，实现了系统正在工作的状态灯效果，数码管表现为一直在转圈，灯则为流水灯效果。

**图 2.2 状态显示电路图**
![image](https://github.com/user-attachments/assets/4eeafe2e-d2c9-47a4-ab4b-24e40a332637)

### 2.2.2 按键输入部分

**图 2.3 按键部分电路图**
![image](https://github.com/user-attachments/assets/6557c994-adf4-4432-8f99-92fc10d0463f)

左下方为按键信号输入部分，四个按键接入后先取反，然后接入到 compare 比较器模块中，同时四线进行或后输入到 key_press 端口，假如有按钮按下就为 1。
Random 模块接入时钟后源源不断产生伪随机信号其信号需要输入到 compare 中完成比较，compare 的输出 sc_n,bell,false 送到后面处理；
同时随机的信号需要去完成点灯的任务，由于按下按键的影响，因此需要和后面的 dy_time 模块的 endflag 继续与处理，意味着结束测试后，全部灯都变为灭。

### 2.2.3 错误计数显示部分

**图 2.4 错误计数部分电路图**
![image](https://github.com/user-attachments/assets/46bc99f8-3c6b-43b5-9885-4ace935b0e32)

Wrong_in 接入从 compare 中输出的 false 信号，即 false 每触发一次就望 wrongcount 模块输入一个计数信号，计数信号显示到静态数码管中，其中 reset 连到 start 键，意味着重新开始时重新进行错误次数的计数，并且将 4timeflag6 接到指示灯中，表示如果超过四次，那么也算失败，同时也会显示 fail，并且添加了或门和与门来增加了测试通过的条件，若时间小于 10 秒，但是错误次数大于 4，那么也显示 fail，只有都符合的情况下才显示 pass。

### 2.2.4 计数器动态数码管显示（平均时间，pass/fail）

**图 2.5 动态数码管显示电路图**
![image](https://github.com/user-attachments/assets/6c663b19-d7c3-45e1-8c6e-efa5caf3f986)

最为复杂的接线部分，首先时 dy_gen 模块，接入时钟后它会产生源源不断的刷新信号，在刷新信号的周期内同时给数码管发送信号，那么该位选对应的数码管就会显示相应的数字，由于 74244 为低电平有效，因此集成块特意留出了与之相反的通道，通道接到动态数码管的位选上，实现刷新功能。
接着是 dy_time 模块，它先接入对应的时钟和刷新信号，因为该模块内部还有总线刷新的电路部分，因此还需要接入刷新信号，sc 接入的时前面的 sc_n 信号，传入按键正确的信号，其输出的 abcdefg 数码管信号要接入到 74244 中走总线再到数码管，这个后面再进行分析；failflag 和 success 接到输出灯的引脚，完成状态的显示。
对于 wr_pa（wrong_pass）模块，输入的是刷新信号和 fail/pass 的信号，输出则是对应 fail/pass 信号的字母二进制信号，其内部还有刷新的总线设计，理论同上，不过多赘述。
到外部总线设计，两个模块引出的数码管信号都接入到 74244 中，当 endflag 为 1 的时候，意思完成了测试，将其信号与 0.5hz 的时钟信号或非，实现结束时，两种信号的交替显示，即显示平均时间，也显示 pass/fail，同时还得将两个的使能信号相反处理，即一个接非门，避免刷新的冲突。
平均时间的实现则是移动小数点，将 endflag 和 sel1 和 sel2 相与，然后接入到 74244 中参与刷新；当结束时，endflag 为 1，其信号与 sel1/sel2 相与（一个取反一个不取反），则可得到移动的小数点，当没有结束时，endflag 为 0，小数点在原来位置。

## 2.3 输入输出波形仿真

**图 2.6 仿真波形图 1**
![image](https://github.com/user-attachments/assets/f2e3c807-3e9a-45c6-9275-ee2a789e7188)

从上图可见，当按下对应的按键后，bibi 会进行响应，对应就是扬声器会有声响，同时 dy_time_show 组出现暂停的现象，也就是计时器暂停计数；但是调试出现一些问题，比如按下 4，但是没有反应，但是实际测试中是可行的。

**图 2.7 仿真波形图 2**
![image](https://github.com/user-attachments/assets/8851566d-5409-442c-bdd0-bb7ed445a33b)

当按下 start 时候，重新进行计数，可见上图，其又增加了 20s 的计时时间。

## 2.4 调试说明及分析

### 2.4.1 成功通过测试条件验证

**图 2.8 测试通过图 1**
![image](https://github.com/user-attachments/assets/1de07862-9684-42af-872c-e778db49371e)

**图 2.9 测试通过图 2**
![image](https://github.com/user-attachments/assets/0d78417f-4619-429e-b367-be3f8863c63c)

按错次数少于 4，时间小于 10s，测试通过，l7 灯亮起，显示 pass。

### 2.4.2 超时失败测试条件验证

**图 2.10 超时情况 1**
![image](https://github.com/user-attachments/assets/68b0e3d4-1492-4015-94a4-a402ae01cdd4)

**图 2.11 超时情况 2**
![image](https://github.com/user-attachments/assets/9d178ff9-1958-469f-9767-7bb40787dc91)

时间超过 10s，l8 灯亮起，显示 fail，测试不通过。

### 2.4.3 按错次数过多失败测试条件验证

**图 2.12 错误过多情况 1**
![image](https://github.com/user-attachments/assets/3c195eb8-d8a5-45d5-a739-827a8fb1e6bf)

**图 2.13 错误过多情况 2**
![image](https://github.com/user-attachments/assets/3b228c11-3184-49a1-836e-32e117825828)

即使时间小于 10s，但是按错次数超过 4 次，那么测试也不通过，显示 fail，L8 和 l6 同时亮起。

# 3 异常问题及解决方法

## 3.1 错误计数模块问题

错误计数模块存在显示 fail（结束测量）后，继续在按键中按，也会增加其计数的问题。理论上，在测试结束后，电路处于“暂停”的状态，需要通过控制电路再次激活电路来重新计数，而控制电路就是 start 按键和周围的触发器组成，目前的解决办法是增加 start 和计数电路之间的关联，增加集成块中的控制输入信号，将其问题避免。

## 3.2 动态扫描管刷新问题

对于刷新信号，我采用的是 1000hz 的信号，课程上似乎用的是 100hz，我看其他同学也是 100hz，会发生频闪的问题，而使用 1000hz 就完美解决了这个问题；但是不知道是否是感官上的问题，高刷新率的情况下，0.01s 位上的数字闪动很明显，使用手机上的高速摄影功能，拍下了刷新的过程，也证明了设计没有问题，数字确实是一位一位走的，因为 0.01s 太快了。如下图所示，为拍摄的照片。

**图 3.1 高速摄像图 1**
![image](https://github.com/user-attachments/assets/54214898-fa84-4e84-ae6a-59ff37eeded0)

**图 3.2 高速摄像图 2**
![image](https://github.com/user-attachments/assets/e8b64ac3-1880-4a5e-82b0-057f97d40d53)

## 3.3 时序仿真波形与功能性仿真差异

**图 3.3 时序仿真图**
![image](https://github.com/user-attachments/assets/2dbced48-1320-4f22-8535-91840f1db921)

比如在灯的位置，出现了一些毛刺的现象，造成的原因可能是其各个集成产生了一定的时延累积后，在处理过程中出现了空隙造成的。
