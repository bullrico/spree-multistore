# Spree MultiStore Extension
The goal is to be able to host multiple stores with one Spree app. 

# Assumptions:
Individual stores are accessed like this:
<pre>
http://example.com/store1 and http://example.com/store2
</pre>

Admin URL:
<pre>
http://example.com/admin
</pre>
Store will be read via a current_store method using session[:store_id], similar to current_user

