// Definition of code parameters
DEFPARAM CumulateOrders = False // Cumulating positions deactivated
// The system will cancel all pending orders and close all positions at 0:00. No new ones will be allowed until after the "FLATBEFORE" time.
DEFPARAM FLATBEFORE = 100000
// Cancel all pending orders and close all positions at the "FLATAFTER" time
DEFPARAM FLATAFTER = 080000

// Conditions to enter long positions
indicator1 = MACDline[12,26,9](close)
c1 = (indicator1 >= 0)
indicator2 = TenkanSen[9,26,52]
c2 = (indicator2 >= close)
indicator3 = SenkouSpanA[9,26,52]
c3 = (indicator3 >= close)
indicator4 = MonteCarlo[14](close)
c4 = (indicator4 >= 70)
indicator5 = KijunSen[9,26,52]
c5 = (indicator5 >= close)
c6 = (close >= close)

IF c1 AND c2 AND c3 AND c4 AND c5 AND c6 THEN
BUY 1 SHARES AT MARKET
ENDIF

// Conditions to exit long positions
indicator6 = MACDline[12,26,9](close)
indicator7 = MACDSignal[12,26,9](close)
c7 = (indicator6 <= indicator7)
indicator8 = MonteCarlo[14](close)
c8 = (indicator8 <= 40)
indicator9 = TenkanSen[9,26,52]
c9 = (indicator9 <= close)
indicator10 = KijunSen[9,26,52]
c10 = (indicator10 <= close)
indicator11 = SenkouSpanA[9,26,52]
indicator12 = SenkouSpanB[9,26,52]
c11 = (indicator11 >= indicator12)

IF c7 AND c8 AND c9 AND c10 AND c11 THEN
SELL AT MARKET
ENDIF

// Conditions to enter short positions
indicator13 = KijunSen[9,26,52]
c12 = (indicator13 <= close)
indicator14 = TenkanSen[9,26,52]
c13 = (indicator14 <= close)
indicator15 = SenkouSpanA[9,26,52]
indicator16 = SenkouSpanB[9,26,52]
c14 = (indicator15 <= indicator16)
indicator17 = MonteCarlo[14](close)
c15 = (indicator17 <= 40)
indicator18 = MACD[12,26,9](close)
indicator19 = MACDSignal[12,26,9](close)
c16 = (indicator18 >= indicator19)

IF c12 AND c13 AND c14 AND c15 AND c16 THEN
SELLSHORT 1 SHARES AT MARKET
ENDIF

// Conditions to exit short positions
indicator20 = TenkanSen[9,26,52]
c17 = (indicator20 >= close)
indicator21 = KijunSen[9,26,52]
c18 = (indicator21 >= close)
indicator22 = SenkouSpanA[9,26,52]
indicator23 = SenkouSpanB[9,26,52]
c19 = (indicator22 >= indicator23)
indicator24 = MonteCarlo[14](close)
c20 = (indicator24 >= 70)
indicator25 = MACD[12,26,9](close)
indicator26 = MACDSignal[12,26,9](close)
c21 = (indicator25 >= indicator26)

IF c17 AND c18 AND c19 AND c20 AND c21 THEN
EXITSHORT AT MARKET
ENDIF

// Stops and targets
SET STOP pLOSS 40 pTRAILING 40
SET TARGET pPROFIT 80
