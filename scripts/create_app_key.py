import requests
from credentials import auth_url, admin_key

key_owner_name = 'testapp'

r = requests.get(auth_url + '/admin/key',
    headers={
        'Authorization': 'Basic {0}'.format(admin_key)
    }, params={'owner': key_owner_name}, verify=False)


print(r.status_code)
print(r.text)