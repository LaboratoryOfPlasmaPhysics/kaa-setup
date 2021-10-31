import unittest
import numpy as np

class SpacepyPackage(unittest.TestCase):
    def test_ibermpy_is_usable(self):
        from spacepy import coordinates as coord
        coord.Coords(np.random.rand(100,3), 'GSE', 'car')

    def test_can_import_cdf_lib(self):
        from spacepy import pycdf

    def test_can_create_a_simple_cdf(self):
        from spacepy import pycdf
        import datetime
        time = [datetime.datetime(2000, 10, 1, 1, val) for val in range(60)]
        import numpy as np
        data = np.random.random_sample(len(time))
        cdf = pycdf.CDF('MyCDF.cdf', '')
        cdf['Epoch'] = time
        cdf['data'] = data
        cdf.attrs['Author'] = 'John Doe'
        cdf.attrs['CreateDate'] = datetime.datetime.now()
        cdf['data'].attrs['units'] = 'MeV'
        cdf.close()
        # read back 
        cdf = pycdf.CDF('MyCDF.cdf')
        self.assertEquals(data.tolist(), cdf['data'][...].tolist())
        self.assertEquals(time, cdf['Epoch'][...].tolist())
        cdf.close()