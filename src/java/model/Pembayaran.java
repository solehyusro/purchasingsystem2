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
public class Pembayaran {

    private String no_byr;
    private String no_po;
    private String id_admin;
    private String tgl_byr;
    private double total;

    public String getNo_byr() {
        return no_byr;
    }

    public void setNo_byr(String no_byr) {
        this.no_byr = no_byr;
    }

    public String getNo_po() {
        return no_po;
    }

    public void setNo_po(String no_po) {
        this.no_po = no_po;
    }

    public String getId_admin() {
        return id_admin;
    }

    public void setId_admin(String id_admin) {
        this.id_admin = id_admin;
    }

    public String getTgl_byr() {
        return tgl_byr;
    }

    public void setTgl_byr(String tgl_byr) {
        this.tgl_byr = tgl_byr;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }
}
