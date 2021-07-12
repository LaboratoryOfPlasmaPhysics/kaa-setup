import unittest
import numpy as np

class SpwcPackage(unittest.TestCase):
    def setUp(self) -> None:
        import spwc
        spwc.config.proxy_url.set('http://sciqlop.lpp.polytechnique.fr/cache')
        spwc.config.proxy_enabled.set('True')
        return super().setUp()

    def test_can_get_data_from_amda(self):
        import spwc
        from datetime import datetime
        ace_mag = spwc.get_data('amda/imf', datetime(2016,6,2), datetime(2016,6,5))
        self.assertIsNotNone(ace_mag)

    def test_can_get_data_from_cdaweb(self):
        import spwc
        from datetime import datetime
        mms1_mag = spwc.get_data('cdaweb/MMS1_FGM_SRVY_L2/mms1_fgm_b_gsm_srvy_l2_clean', datetime(2019,6,2), datetime(2019,6,2,0,10))
        self.assertIsNotNone(mms1_mag)

    def test_can_get_data_from_sscweb(self):
        import spwc
        from datetime import datetime
        moon_orbit = spwc.get_data('sscweb/moon', datetime(2019,6,2), datetime(2019,8,24), coordinate_system='gse')
        self.assertIsNotNone(moon_orbit)

    def test_can_get_orbit(self):
        import spwc
        from datetime import datetime
        moon_orbit = spwc.get_orbit('moon', datetime(2019,6,2), datetime(2019,8,24), coordinate_system='gse')
        self.assertIsNotNone(moon_orbit)