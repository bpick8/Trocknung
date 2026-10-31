# Berechnung des Trocknungsfortschritt aus den Messwerten relative Feuchte und Temperatur

## Berechnung der absolutgen Feuchte in $\frac{\text{g}}{\text{kg}}$
Berechnung der absoluten Feuchte aus gemessenen Werten 
* relative Feuchtigkeit: rF in Prozent im Wertebereich $[0 .. 100]$
* Temperatur: T in °C: 
* calcValue: absolute Feuchte aF in $\frac{\mathrm{g}}{\mathrm{kg}}$
````java
const calcValue = ((((rF / 100) * (6.112 * Math.pow(2.7182881, (17.62 * T) / (243.12 + T)) * 100)) / 461.5 / (T + 273)) * 1000) / 1.2
````
## Exkurs: Tetens-Gleichung bzw. Magnus Gleichung:
Der Partialdruck eines Gases $e$ innerhalb eines Gasgemisches kann durch Umstellung der [allgemeinen Gasgleichung](https://de.wikipedia.org/wiki/Thermische_Zustandsgleichung_idealer_Gase)
$$
    p \cdot V = n \cdot R_{m} \cdot T  \rightarrow   p = \frac{n}{V} \cdot R_m \cdot T
$$
mit folgender Formel näherungsweise berechnet werden:
$$
    e = \rho \cdot R_m \cdot T 
$$
mit 
* $p$ : Druck $\text{Pa} = \frac{\text{N}}{\text{m}^2} = \frac{J}{\text{m} \cdot \text{m}^2} = \frac{J}{\text{m}^3}$ <p/>
* $V$ : Volumen in $\text{m}^3$ <p/>
* $n$ : Stoffmenge in Mol <p/>
* $R_{m}$ : Gaskonstande 8,31446261815324 $\frac{\mathrm{J}}{\mathrm{mol} \ \mathrm{K}}$ <p/>
* $T$ : Termodynamische Temperatur in Kelvin <p/>



* $\vartheta$ : Termodynamische Temperatur in °C mit $T = 273{,}15 +  \vartheta$<p/>
* $\rho$ : Dichte in $\frac{\text{kg}}{\text{m}^3}$

Für die Dampdichte $\rho_v$ folgt:
$$
    \rho_v = \frac{p}{R_v \cdot T}
$$

Mit Gaskonstante für Wasserdampf: $R = 461,52\,\frac{\text{J}}{\text{kg}\,\text{K}}$ und Sättigungsdampfdruck $\rho(T)$ folgt für den Druck  $p$
$$
    p = \varphi \cdot \rho(T)
$$

Damit kann die __absolute Feuchte__ der Luft in $\text{g} / \text{m}^3$ mit der folgenden Formel berechnet werden:
$$
\rho_v(\varphi, T) = \frac{\varphi \cdot p_s(T)}{R_v \cdot T_K}
$$

mit 
* $\varphi$ : relative Luftfeuchtigkeit im Wertebereich $[0 \dots  1]$
* $p_s(T)$ :  Sättigungsdampfdruck in Pa (*saturation*)
* $R_v = 461,52\, \frac{\text{J}}{\text{kg} \cdot \text{K}}$: Gaskonstante für Wasserdampf (*vapor*)
* $T_K = T_{°\text{C}} + 273,15\, \text{K}$ : Temperatur in Kelvin

Der Sättigungsdampfdruck $p_s(T)$ kann mit der [__Tetens-Gleichung__ bzw. __Magnus Gleichung__](https://www.chemie.de/lexikon/S%C3%A4ttigungsdampfdruck.html) approximiert werden:
$$
    p_s(\vartheta) = 611{,}2\, \text{Pa} \cdot e^{\dfrac{17{,}62 \cdot \vartheta}{\vartheta + 243{,}12°\text{C}}}
$$
wobei $\vartheta$ die Temperatur in °C angegeben ist.
Es gilt: 
* $ -30\,{}^\circ\mathrm{C} \leq 70\,{}^\circ\mathrm{C}$
* $ p_s(\vartheta = 0\,{}^\circ\mathrm{C}) = 6{,}11213\;\mathrm{hPa} = 611{,}213\;\mathrm{Pa}$

Die Konstanten variieren in der Literatur, z.B.:
$$
    p_s(\vartheta) = 611{,}153\, \text{Pa} \cdot e^{\dfrac{22{,}4433 \cdot \vartheta}{\vartheta + 272{,}186°\text{C}}}
$$

## Herleitung und Anlyse der Formel
Implementierte Formel:
$$
    \text{aF}  
    = \frac{\frac{\frac{\text{rF}}{100} \cdot 6{,}112 \cdot 2{,}7182881^{\frac{17{,}62 \cdot \vartheta}{243{,}12 + \vartheta}} \cdot 100}
                  {461{,}5 \cdot (\vartheta + 273)} \cdot 1000}
            {1{,}2} 
$$
Schrittweise Vereinfachung:
$$
    \text{aF}  
    = \frac{\text{rF} \cdot 6{,}112 \cdot e^{\frac{17{,}62 \cdot \vartheta}{243{,}12 + \vartheta}} }
            {461{,}5 \cdot (\vartheta + 273)}
        \cdot \frac{1000}{1,2}
$$
Abbilden auf die  __Tetens-Gleichung__ bzw. __Magnus Gleichung__ und anpassen auf die Einheite $\frac{\text{g}}{\text{kg}}$:
$$
    \text{aF}  
    = \frac{\text{rF} \cdot 611{,}2\, \frac{\text{J}}{\text{m}^3} \cdot e^{\dfrac{17{,}62 \cdot \vartheta}{\vartheta + 243{,}12}}}
    {461{,}52 \frac{\text{J}}{\text{kg} \cdot \text{K}} \cdot (\vartheta + 273{,}15)\, \text{K}}
    \cdot \frac{10}{1{,}204\, \frac{\text{kg}}{\text{m}^3}}
$$
mit 
* $\vartheta$ : Termodynamische Temperatur in °C mit $T = (273{,}15 +  \vartheta)\, \text{K}$<p/>
* Faktor 10: 
    * Umrechnung Prozent im Wertebereich $[0 .. 100]$ in den Wertebereich $[0 .. 1]$
    * Umrechung der Masse von kg in g 
* Die Dichte trockener Luft bei bei Standardbedingungen (20 °C auf Meereshöhe: $101{,}3 \text{Pa}$) beträgt $1,204 \frac{\text{kg}}{\text{m}^3}$. 

Die Formel berechnet die absolute Feuchte nicht wie üblich in Gramm pro Kubikmeter ($\mathrm{g/m}^{\mathrm{3}}$), sondern im Mischungsverhältnis Gramm pro Kilogramm trockene Luft ($\mathrm{g/kg}$). Um von der Masse pro Volumen ($\mathrm{m}^{\mathrm{3}}$) auf die Masse pro Luftmasse ($\mathrm{kg}$) zu kommen, muss durch die Dichte der Luft geteilt werden.

Alle Einheiten können gekürzt werden. Es ergibt sich ein Verhältnis der Masse von Wasserdampf zur Masse von trockener Luft. Damit kann die Einheit  $\frac{\text{g}}{\text{kg}}$ gewählt werden.

Damit ist diese Formel gültig für einen Druck von $101{,}3\, \text{Pa}$. Der Druck in der Prozessluft der Dämmschichttrockung wird davon abweichen. Die Größe der Abweichung und deren Einfluss sind zu betrachten.

# Absolute Feuchte mit Berücksichtigung des Drucks

````python
def absolute_feuchte(temp_c, rf_prozent, druck_pa):
    e_sat = 611.2 * round(2.718281828459045 ** ((17.62 * temp_c) / (temp_c + 243.12)), 10)
    # Using numpy exp or math exp for precision
    import math
    e_sat = 611.2 * math.exp((17.62 * temp_c) / (temp_c + 243.12))
    e = (rf_prozent / 100.0) * e_sat
    af = 622.0 * e / (druck_pa - e)
    return af

af_normal = absolute_feuchte(20, 85, 101325)
af_vakuum = absolute_feuchte(20, 85, 91325)
print(f"Normal: {af_normal:.2f} g/kg")
print(f"Vakuum: {af_vakuum:.2f} g/kg")
````

$$
\text{aF}(\vartheta, \text{rF}, p) = 622 \cdot \frac{\frac{\text{rF}}{100} \cdot 611{,}2 \cdot e^{\frac{17{,}62 \cdot \vartheta}{\vartheta + 243{,}12}}}{p - \left(\frac{\text{rF}}{100} \cdot 611{,}2 \cdot e^{\frac{17{,}62 \cdot \vartheta}{\vartheta + 243{,}12}}\right)} \quad \left[\text{g/kg}\right]
$$

$$
\begin{align*}
e_{\text{sat}}(\vartheta) &= 611{,}2 \cdot e^{\frac{17{,}62 \cdot \vartheta}{\vartheta + 243{,}12}} \quad [\text{Pa}] \\[4ex]
e(\vartheta, \text{rF}) &= \frac{\text{rF}}{100} \cdot e_{\text{sat}}(\vartheta) \quad [\text{Pa}] \\[4ex]
\text{aF}(\vartheta, \text{rF}, p) &= 622 \cdot \frac{e(\vartheta, \text{rF})}{p - e(\vartheta, \text{rF})} \quad \left[\frac{\text{g}}{\text{kg}}\right]
\end{align*}
$$
$$
\begin{align*}
\text{Wobei:} & \\[1ex]
\vartheta &= \text{Temperatur in } ^\circ\text{C} \\
\text{rF} &= \text{Relative Luftfeuchtigkeit in } \% \, (0 \dots 100) \\
p &= \text{Tatsächlicher Gesamtdruck (Betriebsdruck) in Pa} \\
e_{\text{sat}} &= \text{Sättigungsdampfdruck in Pa} \\
e &= \text{Tatsächlicher Wasserdampfpartialdruck in Pa}
\end{align*}
$$

# Dämmschichttrockung
Der Druck in der Prozessluft ist beim Saugen geringer als der Durck im Raum. Der Sättigungsdampfdruck von Wasser beträgt bei einer normalen Raumtemperatur von 20 °C ca. 2.340 Pascal. Damit kann das Wasser verdampfen. 

Der Gesamtdruck in der Dämmschicht sinkt durch den Sauger leicht ab (z. B. von 1013 mbar auf ca. 950 mbar absolut).

> Haben wir eine Chance, den Druck am Sensor in der Prozessluft zu messen?

* __Der Effekt auf die Feuchte:__ Weil der Druck leicht sinkt, dehnt sich die Luft aus. Ihre Dichte sinkt ein wenig (sie wird geringer als die 1,204 kg/m³).
* __Das Ergebnis in der Praxis:__ Die Luft kann durch den veränderten Druck pro Kubikmeter sogar geringfügig mehr Wasserdampf aufnehmen, und die Verdunstung des Wassers in der Dämmschicht wird beschleunigt.
* __Für die Messung:__ Die unkorrigierte Magnus-Formel liefert  immer noch einen praxistauglichen Näherungswert. 

> Diese Aussage sollte hinterfragt werden.

# Berechnung des Ampelstatus
Bei der Berechnung des Ampelstatus wird der Absolutwert der Differenz der absoluten Feuchten in der Prozessluft $\text{aF}_p$ (process) und in der Raumluft $\text{aF}_a$ (ambient) gebildet.
$$
\begin{align*}
    \Delta\text{aF} 
    &=  \left| \text{aF}_p - \text{aF}_a \right| 
    \\[4ex]
    &=
    \frac{\text{rF}_p \cdot 611{,}2\, \frac{\text{J}}{\text{m}^3} \cdot e^{\dfrac{17{,}62 \cdot \vartheta_p}{\vartheta_p + 243{,}12}}}
    {461{,}52 \frac{\text{J}}{\text{kg} \cdot \text{K}} \cdot (\vartheta_p + 273{,}15)\, \text{K}}
    \cdot \frac{10}{1{,}204\, \frac{\text{kg}}{\text{m}^3}}
    - 
    \frac{\text{rF}_a \cdot 611{,}2\, \frac{\text{J}}{\text{m}^3} \cdot e^{\dfrac{17{,}62 \cdot \vartheta_a}{\vartheta_a + 243{,}12}}}
    {461{,}52 \frac{\text{J}}{\text{kg} \cdot \text{K}} \cdot (\vartheta_a + 273{,}15)\, \text{K}}
    \cdot \frac{10}{1{,}204\, \frac{\text{kg}}{\text{m}^3}}
    \\[8ex]
    &=
    \left[
    \text{rF}_p  \cdot
    \frac{ e^{\dfrac{17{,}62 \cdot \vartheta_p}{\vartheta_p + 243{,}12}}}
    { (\vartheta_p + 273{,}15)\, \text{K}}
    - 
    \text{rF}_a \cdot
    \frac{ e^{\dfrac{17{,}62 \cdot \vartheta_a}{\vartheta_a + 243{,}12}}}
    {(\vartheta_a + 273{,}15)\, \text{K}}
    \right]
    \cdot \frac{611{,}2\, \frac{\text{J}}{\text{m}^3}}{461{,}52 \frac{\text{J}}{\text{kg} \cdot \text{K}}}
    \cdot \frac{10}{1{,}204\, \frac{\text{kg}}{\text{m}^3}}
    \\[10ex]
     &=
    \left[
    \frac{\text{rF}_p}{\vartheta_a + 273{,}15} \cdot
    e^{f(\vartheta_p)}
    -
    \frac{\text{rF}_a}{\vartheta_p + 273{,}15} \cdot
    e^{f(\vartheta_a)}
    \right]
    \cdot \text{Konstante}   
\end{align*}
$$
### Ampel Report
Ampelreport (prüfen!!):

| Status | relative Feuchte | Differenz absolute Feuchte |
| ------ | ----- | ---- |
| Rot    | $\text{rF}_i \ge 65\ \%$	            | $\Delta\text{aF} \gt 3\ \frac{\text{g}}{\text{m}^3}$ |
| Gelb   | $65\ \% \gt \text{rF}_i \gt 50\ \%$  | $\Delta\text{aF} \le 3\ \frac{\text{g}}{\text{m}^3}$|
| Grün   | $50 \ge \text{rF}_i$	                | $\Delta\text{aF} \le 2 \ \frac{\text{g}}{\text{m}^3}$ |
| grau   | sonst | sonst|


### Ansatz 1
2D Plot der Funktion im Intervall $[0 \dots 15]$:
$$
    \Delta\text{aF} 
    =  \left| \text{aF}_p - \text{aF}_a \right| 
$$



### Ansatz 2



