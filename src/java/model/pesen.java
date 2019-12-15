/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author USER PC
 */
public class pesen {
    private String nopesan;
    private String tglpesan;
    private Integer total;
    private String kdsupplier;
    private String kdbarang;
    private Integer qty;
    private Double subtotal;

    public String getNopesan() {
        return nopesan;
    }

    public void setNopesan(String nopesan) {
        this.nopesan = nopesan;
    }

    public String getTglpesan() {
        return tglpesan;
    }

    public void setTglpesan(String tglpesan) {
        this.tglpesan = tglpesan;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public String getKdsupplier() {
        return kdsupplier;
    }

    public void setKdsupplier(String kdsupplier) {
        this.kdsupplier = kdsupplier;
    }

    public String getKdbarang() {
        return kdbarang;
    }

    public void setKdbarang(String kdbarang) {
        this.kdbarang = kdbarang;
    }

    public Integer getQty() {
        return qty;
    }

    public void setQty(Integer qty) {
        this.qty = qty;
    }

    public Double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(Double subtotal) {
        this.subtotal = subtotal;
    }      
}
