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
public class Pemesanan {
    private String no_po;
    private String kd_admin;
    private String kd_supp;
    private String kd_brg;
    private String tgl_po;
    private int byk_brg;
    private int harga_satuan;
    private int total;
    private String status;

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public String getKd_admin() {
        return kd_admin;
    }

    public void setKd_admin(String kd_admin) {
        this.kd_admin = kd_admin;
    }

    public String getKd_supp() {
        return kd_supp;
    }

    public void setKd_supp(String kd_supp) {
        this.kd_supp = kd_supp;
    }

    public String getKd_brg() {
        return kd_brg;
    }

    public void setKd_brg(String kd_brg) {
        this.kd_brg = kd_brg;
    }

    public int getByk_brg() {
        return byk_brg;
    }

    public void setByk_brg(int byk_brg) {
        this.byk_brg = byk_brg;
    }

    public String getNo_po() {
        return no_po;
    }

    public void setNo_po(String no_po) {
        this.no_po = no_po;
    }

    public String getTgl_po() {
        return tgl_po;
    }

    public void setTgl_po(String tgl_po) {
        this.tgl_po = tgl_po;
    }

    public int getHarga_satuan() {
        return harga_satuan;
    }

    public void setHarga_satuan(int harga_satuan) {
        this.harga_satuan = harga_satuan;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
}
