package modules.easypay;


public class StopWatch {
	/**
	 * ���� �ð�
	 */
	private long start = 0;

	/**
	 * ���� �ð�
	 */
	private long current = 0;

	/**
	 * ������
	 */
	public StopWatch() {
		reset();
	}

	/**
	 * �ʱ�ȭ
	 */
	public void reset() {
		start = System.currentTimeMillis();
		current = start;
	}

	/**
	 * ���������� �ð��������� ���ð������� ����ð��� �����Ѵ�.
	 * 
	 * @return �и�������
	 */
	public long getElapsed() {
		long now = System.currentTimeMillis();
		long elapsed = (now - current);
		current = now;

		return elapsed;
	}

	/**
	 * ���� �������� ���ð������� ����ð��� �����Ѵ�.
	 * 
	 * @return �и�������
	 */
	public long getTotalElapsed() {
		current = System.currentTimeMillis();

		return (current - start);
	}

	/**
	 * ���������� �ð��������� ���ð������� ����ð��� �����Ѵ�.
	 * 
	 * @return 0h:0m:0s:000ms
	 */
	public String getTimeString() {
		return getTimeString(getElapsed());
	}

	/**
	 * ���� �������� ���ð������� ����ð��� �����Ѵ�.
	 * 
	 * @return 0h:0m:0s:000ms
	 */
	public String getTotalTimeString() {
		return getTimeString(getTotalElapsed());
	}

	/**
	 * �и������带 0h:0m:0s:000ms ���·� �����Ѵ�.
	 * 
	 * @param time
	 *            �и�������
	 * 
	 * @return 0h:0m:0s:000ms
	 */
	protected String getTimeString(long time) {
		int i = 0x36ee80;
		int j = 60000;
		long l1 = time;
		int k = (int) (l1 / (long) i);
		l1 -= (k * i);

		int l = (int) (l1 / (long) j);
		l1 -= (l * j);

		int i1 = (int) (l1 / 1000L);
		l1 -= (i1 * 1000);

		int j1 = (int) l1;

		return k + "h:" + l + "m:" + i1 + "s:" + j1 + "ms";
	}
	
	/**
	 * getTotalTimeString()
	 * 
	 * @return String
	 */
	public String toString() {
		StringBuffer sb = new StringBuffer();

		sb.append(super.toString());
		sb.append("StopWatch value ( ");
		sb.append("totalElapsed=>" + getTotalElapsed() + " ) ");

		return sb.toString();
	}
}