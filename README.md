# The water discharge problem

Code, data, and supplementary materials for the BPNN algorithm of the water discharge problem.

waterdischarge.xlsx: The database we obtained from our experiments.

Algorithm1_waterdischarge.m: The Algorithm 1 as shown in "Algorithm.pdf"

Algorithm2_waterdischarge.m: The Algorithm 2 as shown in "Algorithm.pdf"

Algorithm.pdf: Schematic for our algorithm.

Algorithm.jpg: An jpg version for the schematic.

Figures.pdf: All of the figures in the scientific report.

***

## An optimized algorithm for the prediction of the water emptying time on BPNN

> The water discharge problem is a classic fluid mechanics problem yet hard to resolve due to its complex nature involves water-air interactions that generate air bubbles and vortex. Here, we analytically show that for water discharge in a square pipe, the water emptying time is quadratically proportional to water height and pipe length, and the solution is distributed on a “solution surface” in the t – h – l space. Also, we found out that the water emptying time is shorter with bigger angles, and the water discharge rate is the highest for the Nongfu spring bottle and lowest for the Pocalri bottle. We explain such by bottle shape, depicted by the bottleneck shape and bottle-body trough. We qualitatively show that with a bottle shape depicted by 𝑛 > 1 with our equation, or with a trough on the bottle-body, there is more likely to generate vortex and friction to slow the discharge. For what is more, the bottle-body trough plays a major in our approach. Inspired by the preceding approaches to solving fluid mechanics problems with machine learning, specifically using neural networks, we build a regression model based on our experimental data of the water discharge with BPNN to obtain the satisfied network through a strategy we called “Lucky-Draw”. We obtain that for our data the best BPNN parameters are: 𝜉 = 1 and 𝛼 = 10^-3. Henceforth, we generate the satiated network with our algorithm shows good accuracy. We also implement a randomly generated dataset to get a prediction from our network. 
