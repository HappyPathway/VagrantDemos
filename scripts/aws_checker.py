from boto import  ec2
import sys
e_conn = ec2.connect_to_region('us-east-1')
for x in e_conn.get_only_instances(filters={'tag:Owner': sys.argv[1]}):
    print x.tags.get('Name')
