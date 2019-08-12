# CBRS
Conveyor Belt Router System

Aluno: Cleber Ferreira
Orientador: Prof. Dr. Leandro Colombi Resendo
A combinação dos equipamentos do porto como viradores de vagões, empilhadeiras,
recuperadoras, correias transportadoras e carregadores de navios, usados para levar o
minério da ferrovia ao navio, são denominados de rotas de equipamentos. Os viradores de
vagões e recuperadoras são considerados como origens, as empilhadeiras e carregadores de
navios são os destinos e as correias transportadoras formam o caminho (rota).
A proposta do trabalho é a escolha da melhor rota de correias transportadoras orientado
pelas seguintes heurísticas:
1. Caminho mínimo: cada correia tem um tamanho diferente, sendo assim o tempo de
viagem do material é influenciado pelo somatório dos tamanhos das correias. O desafio
é encontrar o caminho mínimo da rota utilizando solução baseado no algoritmo de
Dijkstra;
2. Menor consumo de energia: cada equipamento tem um consumo nominal de energia,
o somatório do consumo dos equipamentos que compõe a rota determina o consumo
geral da rota. A otimização deverá encontrar a rota com menor consumo;
3. Contaminação de material: deve-se garantir que as rotas em operação não misturem o
material, ou seja, o tipo de material enviado pela origem deve ser o mesmo recebido
pelo destino;
4. Capacidade das correias: cada correira transportadora suporta uma carga máxima, nos
casos em que mais de uma rota compartilham a mesma correia, a otimização não pode
exceder o limite nominal de carga da rota.
Para realizar esta tarefa primeiro será desenvolvido um modelo de banco de dados relacional,
modelando as rotas de correias transportadoras em grafos e os processos produtivos do
porto. Além disto será desenvolvido um software que comunica com o banco de dados
relacional que utilizará as técnicas de busca gulosa ensinadas na disciplina de inteligencia
artificial para a decisão de melhor rota orientado pelas heurísticas citadas acima.

Metas:

1 - Criar um modelo de banco de dados relacional - Grafo de Rotas - concluído;
  Utilizar o SQLServer Express para modelar um banco de dados relacional considerando a teoria de Grafos onde constará Origem (Vértices), transferencia de material origem para correia, correia para correia ou correia para destinos (Vértices), correias transportadoras (Arestas) e Destino (Vértices). Gerar um banco de dados alimentando os equipamentos de um porto de minério.
  
2 - Criar um modelo de banco de dados relacional - Especialização do processo do porto  - concluído;
Adicionar ao modelo de Grafo os particularidades do processo do porto como pátio de estocagem, pieres, usinas de pelotização e usina siderurgica.

3 - Desenvolvimento de Software de otimização - Previsão de conclusão 16/08/19
Criar software capaz de trocar informações com o banco de dados para a realização da otimização na escolha da melhor rota levando em consideração as 4 heurísticas descritas na introdução. 

4 - Testes e simulações do processo - Previsão de conclusão 21/08/19
Simular a escolha de rota de acordo com situações reais do processo e comparar as rotas escolhidas com as outras opções de rotas afim de concluir se realmente a melhor rotas está sendo escolhida.

Exemplo:

Da origem A até destino B temos 10 opções de rotas:

O algoritmo deve escolher a melhor opção de acordo com as heurísticas definidas e parâmetros de priorização da escolha da rota;
Após a escolha vou comparar a rota escolhida com as demais rotas e verificar se o algoritmo escolheu a melhor rota, pontuando cada uma das rotas.

5 - Rascunho do artigo - Previsão de conclusão 26/08/19
Ao longo das metas aqui citadas elaborar um rascunho de artigo.

6 - Versão final do artigo - Previsão de conclusão 08/09/19
Utilizar as anotações do rascunho do artigo e elaborar um artigo sobre o trabalho.

Bibliografia

Esta dissertação discreve uma otimização nos processos de uma mineradora
VIEIRA, RMT. Distribuição de lotes carregados de minério de ferro ferrovia-porto:
uma abordagem por simulação a eventos discretos. 2018. Dissertação (Mestrado) —
Universidade Federal do Espírito Santo, 2018.

Este artigo mostra uma otimização realizadas em rotas de correias para transporte de carvão.
ZHANG, Shirong; XIA, Xiaohua. Optimal control of operation efficiency of belt conveyor
systems. Applied Energy, v. 87, n. 6, p. 1929 – 1937, 2010. ISSN 0306-2619. Disponível em:
<http://www.sciencedirect.com/science/article/pii/S0306261910000085>.

Este artigo utiliza SQLServer, Java rodando o algoritmo de Dijkstra.
@article{khaing2018using,
  title={Using Dijkstra’s algorithm for public transportation system in yangon based on GIS},
  author={Khaing, Ohnmar and Wai, H and Myat, E},
  journal={Int J Sci Eng Appl},
  volume={7},
  number={11},
  pages={442--447},
  year={2018}
}
