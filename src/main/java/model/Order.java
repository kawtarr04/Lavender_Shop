package model;

public class Order extends Product{
    private int orderId;
    private int uid;
    private int quantity;
    private String date;

    private String userName;
    private String statutPaiement;

    public Order() {
    }

    public Order(int orderId, int uid, int quantity, String date) {
        super();
        this.orderId = orderId;
        this.uid = uid;
        this.quantity = quantity;
        this.date = date;
    }

    public Order(int uid, int quantity, String date) {
        super();
        this.uid = uid;
        this.quantity = quantity;
        this.date = date;
    }

    public int getOrderId() {
        return orderId;
    }
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public int getQuantity() {
        return quantity;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    public String getDate() {
        return date;
    }
    public void setDate(String date) {
        this.date = date;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getStatutPaiement() {
        return statutPaiement;
    }

    public void setStatutPaiement(String statutPaiement) {
        this.statutPaiement = statutPaiement;
    }
}
