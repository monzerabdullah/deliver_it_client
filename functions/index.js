const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.notifyStoreOnReadyToStart = functions.firestore
  .document('orders/{orderId}')
  .onUpdate((change, context) => {
    const orderId = context.params.orderId;
    const newValue = change.after.data();
    const previousValue = change.before.data();

    if (newValue.status === 'ready_to_start' && previousValue.status !== 'ready_to_start') {
      const storeId = newValue.store_id;
      return admin.firestore().collection('stores').doc(storeId).get().then(storeDoc => {
        const storeData = storeDoc.data();
        const notification = {
          notification: {
            title: 'Order Ready to Start',
            body: `Order ${orderId} is ready to start.`,
          },
          token: storeData.fcm_token,
        };
        return admin.messaging().send(notification);
      });
    }
    return null;
  });
