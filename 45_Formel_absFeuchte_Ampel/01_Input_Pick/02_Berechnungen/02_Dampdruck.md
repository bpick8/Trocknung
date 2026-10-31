# Dampdruck
https://www.chemie.de/lexikon/Dampfdruck.html

https://www.schweizer-fn.de/lueftung/feuchte/feuchte.php

https://de.wikipedia.org/wiki/S%C3%A4ttigungsdampfdruck

# Wasserdampfdruck
 

Existieren Wasser und Wasserdampf im thermodynamischen Gleichgewicht nebeneinander, so ist der Druck eine reine Funktion der Temperatur:

$$
    \rho = p_s(T) 
$$

Dieser temperaturabhängige und stoffspezifische Druck wird als __Dampfdruck__ und der Graph dieser Funktion als Dampfdruckkurve bezeichnet. Die Dampfdruckkurve endet im kritischen Punkt.

Bei Erhöhung der Temperatur steigen Dampfdruck und Dampfdichte stark an, während die Dichte der Flüssigkeit abnimmt. Die Eigenschaften von Wasser und Dampf werden mit steigender Temperatur immer ähnlicher, bis am __kritischen Punkt__ bei $T = Tc = 374,12\,°\text{C}$ und $p = p_c = 221,2\, \text{bar}$ der Unterschied ganz verschwunden ist und nur noch eine einzige Phase existiert. Bei Annäherung an den kritischen Punkt verschwindet die Verdampfungswärme und es treten starke Dichtefluktuationen auf, erkennbar als kritische Opaleszenz. 

# Wasserdampfdruck in der Meteorologie
In der Meteorologie wird unter der Bezeichnung __Dampfdruck__ meist der Dampfdruck des Wasserdampfs (Wasserdampfdruck) und somit sein Partialdruck verstanden. __Die Dampfdichte entspricht der absoluten Luftfeuchtigkeit__.

Der Dampfdruck nach Definition der Meteorologie, also der Partialdruck eines Gases innerhalb eines Gasgemisches, kann durch Umstellung der allgemeinen Gasgleichung mit folgender Formel näherungsweise berechnet werden:

$$
    e = \rho_i \cdot R_i \cdot T 
$$


Die einzelnen Formelzeichen stehen für folgende Größen:

* $e$      - Dampfdruck
* $\rho_i$ - Dampfdichte
* $R_i$    - individuelle Gaskonstante
* $T$      - Temperatur 

Die individuelle Gaskonstante für Wasserdampf beträgt 461,5 J/(kg K). 

# Dampfdichte
$$
    e = \rho_i \cdot R_i \cdot T 
$$

Mit Gaskonstante für Wasserdampf (*vapor*): $R_v = 461,52\,\frac{\text{J}}{\text{kg}\,\text{K}}$

$$
    \rho_v = \frac{e}{R_v \cdot T}
$$

Für den Dampfdruck $e$: Sättigungsdampfdruck in Abhängigkeit der Temperatur $\rho_s(T)$
$$
e \Rightarrow \varphi\cdot\rho_s(T)
$$
Die __Dampfdichte der Luft__ (Wasserdampfgehalt in g/m³) kann mit der folgenden Formel berechnet werden:

$$
\rho_v(\varphi, T) = \frac{\varphi \cdot p_s(T)}{R_v \cdot T_K}
$$
mit 
* $\varphi$: relative Luftfeuchtigkeit (0 bis 1)
* $p_s(T)$:  Sättigungsdampfdruck in Pa (*saturation*)
* $R_v = 461,52$: J/(kg·K), die Gaskonstante für Wasserdampf (*vapor*)
* $T_K = T_{°\text{C}} + 273,15\, \text{K}$: Temperatur in Kelvin

Der Sättigungsdampfdruck $p_s(T)$ kann mit der __[Tetens-Gleichung](https://en.wikipedia.org/wiki/Tetens_equation)__ approximiert werden:

$$
p_s(T) = 610,94\, \text{Pa} \cdot e^{\dfrac{17.625 \cdot T}{T + 243,04°\text{C}}}
$$

wobei  T die Temperatur in °C ist.

Ebenso wird die __Magnus-Formel__ beschrieben:
$$
p_s(T) = 603,28\, \text{Pa} \cdot e^{\dfrac{17,1485 \cdot T}{T + 243,69°\text{C}}}
$$
Mit der Temperatur in °C. 

## Berechnung der Dampfdichte in python

```python
def vapordensity(temp_c, rel_f):
    """
    :param temp_c: temperature in degree celsius
    :param rel_f: Relative humidity in percent
    :return: vapordensity in g/m³

    values from: https://www.schweizer-fn.de/lueftung/feuchte/feuchte.php
    """
    p_s = 611.2 * math.exp( (17.62* temp_c) / (temp_c + 243.12) )   
    return (rel_f/100 * p_s) / (461.52 * (temp_c + 273.15)) * 1000
```




